//
//  ChemistryDetailVC.m
//  law-ios
//
//  Created by xueyang.li on 2018/2/1.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "ChemistryDetailVC.h"

@interface ChemistryDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tvList;
@property (nonatomic, strong)NSArray *arrData;
@property (nonatomic, assign)bool isSC;//是否收藏
@property (nonatomic, strong ) NSArray *arrHead;

@end

@implementation ChemistryDetailVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arrHead = @[@{@"中文名字":self.name},@{@"英文名字":self.ename},@{@"CAS编号":self.cas},@{@"分子式":self.molecularFormula}];
}

-(void)bindView {
    self.title = self.name;
    self.tvList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,WIDTH_, HEIGHT_ - 64) style:UITableViewStyleGrouped];
    self.tvList.delegate = self;
    self.tvList.dataSource = self;
    [self.view addSubview:self.tvList];
    self.btnRight.hidden = NO;
    [self.btnRight setImage:[UIImage imageNamed:@"文章收藏icon_未收藏"] forState:UIControlStateNormal];
}

-(void)onRightAction{
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:@"wxhxp" forKey:@"typeCode"];
    [mdict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"login"] forKey:@"userId"];
    [mdict setValue:self.ID forKey:@"lawId"];
    
    if (!self.isSC) {
        [self POSTurl:ADD_FAVORITE parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
            
            [ws.btnRight setImage:[UIImage imageNamed:@"文章收藏icon_已收藏"] forState:UIControlStateNormal];
            ws.isSC = YES;
            [[Toast shareToast]makeText:@"收藏成功" aDuration:1];
            
            [SVProgressHUD dismiss];
        } failure:^(id responseObject) {
            [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
            [SVProgressHUD dismiss];
        }];
    }else{
        [self POSTurl:CANCEL_FAVORITE parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
            
            [ws.btnRight setImage:[UIImage imageNamed:@"文章收藏icon_未收藏"] forState:UIControlStateNormal];
            ws.isSC = NO;
            [[Toast shareToast]makeText:@"取消收藏成功" aDuration:1];
            
            [SVProgressHUD dismiss];
        } failure:^(id responseObject) {
            [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
            [SVProgressHUD dismiss];
        }];
    }
}

-(void)getData {
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:self.ID forKey:@"id"];
    [mdict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"login"] forKey:@"userId"];
    [mdict setValue:@"wxhxp" forKey:@"typeCode"];
    
    [self POSTurl:GET_CHEMICALSDETAILS parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        NSString *st = responseObject[@"data"][@"chemicalsDetails"];
        NSDictionary *dic = [self arrayWithJsonString:st];
        if([dic[@"is_favorite"]intValue] == 1){
            [ws.btnRight setImage:[UIImage imageNamed:@"文章收藏icon_已收藏"] forState:UIControlStateNormal];
            ws.isSC = YES;
        }
        ws.arrData = dic[@"details"];
        [ws.tvList reloadData];
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
    }];
}

/**
 *  UITableViewDelegate
 *
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrData.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 4;
    }
    NSArray *arrList = self.arrData[section-1][@"list"];
    return arrList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [NSString stringWithFormat:@"%li===%li",(long)indexPath.section,(long)indexPath.row ];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section ==0) {
        NSDictionary *dic = self.arrHead[indexPath.row];
        cell.textLabel.text = dic.allKeys[0];
        cell.detailTextLabel.text = dic.allValues[0];
        if (WIDTH_>320) {
            cell.detailTextLabel.numberOfLines = 0;
        }
        return cell;
    }
    NSArray *arrList = self.arrData[indexPath.section-1][@"list"];
    NSDictionary *dic= arrList[indexPath.row];
    NSString *st = [NSString stringWithFormat:@"%@:",dic[@"key"]];
    cell.textLabel.text = [st substringFromIndex:2];
    cell.detailTextLabel.text =dic[@"value"];
    if (WIDTH_>320) {
        cell.detailTextLabel.numberOfLines = 0;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        NSDictionary *dic = self.arrHead[indexPath.row];
        NSString *st = dic.allValues[0];
        CGSize textSize = [st boundingRectWithSize:CGSizeMake(WIDTH_ - 150, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        if (textSize.height >60) {
            return textSize.height + 30;
        }
        return 60;
    }
    NSArray *arrList = self.arrData[indexPath.section-1][@"list"];
    NSDictionary *dic= arrList[indexPath.row];
    NSString *st = [NSString stringWithFormat:@"%@:",dic[@"key"]];
    CGSize textSize = [dic[@"value"] boundingRectWithSize:CGSizeMake(WIDTH_ - 150, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    if (textSize.height >60) {
        return textSize.height + 30;
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 4;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return nil;
    }
    NSString *st = self.arrData[section-1][@"title"];
    UILabel *lb = [UILabel new];
    lb.text = [NSString stringWithFormat:@"  %@",st];
    return lb;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

@end
