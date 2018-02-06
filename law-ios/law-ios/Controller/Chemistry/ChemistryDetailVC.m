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
@end

@implementation ChemistryDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [mdict setValue:self.ID forKey:@"userId"];
    [mdict setValue:self.ID forKey:@"lawId"];
    
    
    [self POSTurl:GET_CHEMICALSDETAILS parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        NSString *st = responseObject[@"data"][@"chemicalsDetails"];
        NSDictionary *dic = [self arrayWithJsonString:st];
        ws.arrData = dic[@"details"];
        [ws.tvList reloadData];
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
    }];
    
     [self.btnRight setImage:[UIImage imageNamed:@"文章收藏icon_已收藏"] forState:UIControlStateNormal];
    [[Toast shareToast]makeText:@"收藏成功" aDuration:1];
}

-(void)getData {
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:self.ID forKey:@"id"];
    
    
    [self POSTurl:GET_CHEMICALSDETAILS parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        NSString *st = responseObject[@"data"][@"chemicalsDetails"];
        NSDictionary *dic = [self arrayWithJsonString:st];
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
    return self.arrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *arrList = self.arrData[section][@"list"];
    return arrList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [NSString stringWithFormat:@"%li===%li",(long)indexPath.section,(long)indexPath.row ];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    NSArray *arrList = self.arrData[indexPath.section][@"list"];
    NSDictionary *dic= arrList[indexPath.row];
    NSString *st = [NSString stringWithFormat:@"%@:",dic[@"key"]];
    cell.textLabel.text = [st substringFromIndex:2];
    cell.detailTextLabel.text =dic[@"value"];
    cell.detailTextLabel.numberOfLines = 0;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *arrList = self.arrData[indexPath.section][@"list"];
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
    NSString *st = self.arrData[section][@"title"];
    UILabel *lb = [UILabel new];
    lb.text = [NSString stringWithFormat:@"  %@",st];
    return lb;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

@end
