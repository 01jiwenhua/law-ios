//
//  SEARCHLISTVC.m
//  law-ios
//
//  Created by 刘磊 on 2018/2/4.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "SEARCHLISTVC.h"
#import "ListTableViewCell.h"
#import "AXWebViewController.h"
@interface SEARCHLISTVC ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchBarDelegate>
@property (nonatomic,strong)UITableView * tbv;
@property (nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation SEARCHLISTVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.page = 0;

    self.tbv.frame = CGRectMake(0,0, WIDTH_, HEIGHT_ - 108);
    [self.view addSubview:self.tbv];
    
    WS(ws);
    self.tbv.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        ws.page = 0;
        [self getData];
    }];
    
    self.tbv.mj_footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        ws.page ++;
        [self getData];
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.page = 0;
    [self getData];
    UIView * vi = [[UIApplication sharedApplication].delegate.window viewWithTag:11111];
    if (vi) {
        [vi removeFromSuperview];
    }
    
}
-(void)getData{
    WS(ws);
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    
    if (self.typeCode.length > 0) {
        [mdict setValue:self.typeCode forKey:@"typeCode"];

    }
    if (self.level.length > 0) {
        [mdict setValue:self.level forKey:@"level"];

    }
    if (self.searchStr.length > 0) {
        [mdict setValue:self.searchStr forKey:@"description"];
        [mdict setValue:self.searchStr forKey:@"name"];
    }
    else {
        [ws.dataArr removeAllObjects];
        [ws.tbv reloadData];
        return ;
    }
    [mdict setValue:[NSNumber numberWithInt:self.page + 1] forKey:@"page"];
    [mdict setValue:@10 forKey:@"pageSize"];
    [SVProgressHUD showWithStatus:@"加载中..."];

    [self POSTurl:GET_LAWLIST parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        NSString *st = responseObject[@"data"][@"lawList"];
        NSArray *arr = [self arrayWithJsonString:st];
        if (ws.page == 0) {
            [ws.dataArr removeAllObjects];
        }
        for (NSDictionary *dic in arr) {
            [ws.dataArr addObject:dic];
        }
        [ws.tbv reloadData];
        [ws.tbv.mj_header endRefreshing];
        [ws.tbv.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [ws.tbv.mj_header endRefreshing];
        [ws.tbv.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ListTableViewCell" forIndexPath:indexPath];
    
    NSMutableAttributedString * mStr0 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",[self.dataArr[indexPath.row]  valueForKey:@"lawName"]]];
    NSRange range0 = [mStr0.string rangeOfString:self.searchStr];
    if (range0.length > 0) {
        [mStr0 addAttribute:NSForegroundColorAttributeName value:RGBColor(114, 177, 245) range:range0];
    }
    cell.TitlrLab.attributedText = mStr0;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    cell.mLab.text = [NSString stringWithFormat:@"%@",[self.dataArr[indexPath.row]  valueForKey:@"issueNo"]];
    cell.timeNewLab.text = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[[self.dataArr[indexPath.row]  valueForKey:@"publishTime"] doubleValue]/ 1000]];
    
    cell.DLab.text = [NSString stringWithFormat:@"%@",[self.dataArr[indexPath.row]  valueForKey:@"description"]];
    
    
    NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",[self.dataArr[indexPath.row]  valueForKey:@"description"]]];
    NSRange range = [mStr.string rangeOfString:self.searchStr];
    if (range.length > 0) {
        [mStr addAttribute:NSForegroundColorAttributeName value:RGBColor(114, 177, 245) range:range];
        
    }
    cell.DLab.attributedText = mStr;
    if(mStr.length <=0) {
        cell.DLab.text = @"暂无摘要";
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AXWebViewController *webVC = [[AXWebViewController alloc] initWithAddress:@"http://www.bjsafety.gov.cn/art/2018/2/1/art_612_3641.html"];
    NSDictionary *dic= self.dataArr[indexPath.row];
    [self.navigationController pushViewController:webVC animated:YES];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 11111;
    [btn setFrame:CGRectMake(WIDTH_ - 44, 27, 44, 30)];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [[UIApplication sharedApplication].delegate.window addSubview:btn];
    
    if([dic[@"is_favorite"]intValue] == 1){
        //已收藏
        [btn setImage:[UIImage imageNamed:@"文章收藏icon_已收藏"] forState:UIControlStateNormal];
    } else {
        [btn setImage:[UIImage imageNamed:@"文章收藏icon_未收藏"] forState:UIControlStateNormal];
    }
    WS(ws);
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSMutableDictionary * mdict = [NSMutableDictionary new];
        [mdict setValue:ws.typeCode forKey:@"typeCode"];
        [mdict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"login"] forKey:@"userId"];
        [mdict setValue:dic[@"id"] forKey:@"lawId"];
        if([dic[@"is_favorite"]intValue] == 1) {
            [ws POSTurl:CANCEL_FAVORITE parameters:@{@"data":[ws dictionaryToJson:mdict]} success:^(id responseObject) {
                
                [btn setImage:[UIImage imageNamed:@"文章收藏icon_未收藏"] forState:UIControlStateNormal];
                
                [[Toast shareToast]makeText:@"取消收藏成功" aDuration:1];
                
                [SVProgressHUD dismiss];
            } failure:^(id responseObject) {
                [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
                [SVProgressHUD dismiss];
            }];
        }else {
            [ws POSTurl:ADD_FAVORITE parameters:@{@"data":[ws dictionaryToJson:mdict]} success:^(id responseObject) {
                [btn setImage:[UIImage imageNamed:@"文章收藏icon_已收藏"] forState:UIControlStateNormal];
                [[Toast shareToast]makeText:@"收藏成功" aDuration:1];
                [SVProgressHUD dismiss];
            } failure:^(id responseObject) {
                [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
                [SVProgressHUD dismiss];
            }];
        }
        
    }];
    
}

-(UITableView *)tbv {
    if (!_tbv) {
        UITableView * tbv = [UITableView new];
        [tbv registerClass:[ListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ListTableViewCell class])];
        tbv.delegate = self;
        tbv.dataSource = self;
        tbv.separatorStyle = UITableViewCellSeparatorStyleNone;

        _tbv = tbv;
    }
    return _tbv;
}

-(NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

-(NSString *)searchStr {
    if (_searchStr && _searchStr.length > 0) {
        return [NSString stringWithFormat:@"%@",_searchStr];
        
    }
    return @"";
}
@end
