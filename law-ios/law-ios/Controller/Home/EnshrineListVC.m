//
//  EnshrineListVC.m
//  law-ios
//
//  Created by 刘磊 on 2018/2/4.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "EnshrineListVC.h"
#import "ListTableViewCell.h"
#import "AXWebViewController.h"

@interface EnshrineListVC ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchBarDelegate>
@property (nonatomic,strong)UITableView * tbv;
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,assign)int page;
@end

@implementation EnshrineListVC
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"收藏";
    self.page = 0;
    [self getData];
    UIView * vi = [[UIApplication sharedApplication].delegate.window viewWithTag:11111];
    if (vi) {
        [vi removeFromSuperview];
    }
    
    UIView * vi1 = [[UIApplication sharedApplication].delegate.window viewWithTag:22222];
    if (vi1) {
        [vi1 removeFromSuperview];
    }
    
    UIView * vi2 = [[UIApplication sharedApplication].delegate.window viewWithTag:33333];
    if (vi2) {
        [vi2 removeFromSuperview];
    }
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.page = 0;
    
    self.tbv.frame = CGRectMake(0,0, WIDTH_, HEIGHT_ - 108);
    [self.view addSubview:self.tbv];
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_, 0.5)];
    line.backgroundColor = LINE;
    [self.view addSubview:line];
    
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


-(void)getData{
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    
    if (self.typeCode.length > 0) {
        [mdict setValue:self.typeCode forKey:@"typeCode"];
        
    }
    if (self.level.length > 0) {
        [mdict setValue:self.level forKey:@"level"];
        
    }
    [mdict setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"login"] forKey:@"userId"];
    [mdict setValue:[NSNumber numberWithInt:self.page + 1] forKey:@"page"];
    [mdict setValue:@10 forKey:@"pageSize"];
    [self POSTurl:GET_FavoriteList parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        NSString *st = responseObject[@"data"][@"favoriteList"];
        NSArray *arr = [self arrayWithJsonString:st];
        if (ws.page == 0) {
            [ws.dataArr removeAllObjects];
        }
        for (NSDictionary *dic in arr) {
            [ws.dataArr addObject:dic];
        }
        if (ws.dataArr.count==0) {
            [[Toast shareToast]makeText:@"暂未收录此内容" aDuration:1];
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
    cell.TitlrLab.text = [NSString stringWithFormat:@"%@",[self.dataArr[indexPath.row]  valueForKey:@"lawName"]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    cell.mLab.text = [NSString stringWithFormat:@"%@",[self.dataArr[indexPath.row]  valueForKey:@"issueNo"]];
    cell.timeNewLab.text = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[[self.dataArr[indexPath.row]  valueForKey:@"publishTime"] doubleValue]/ 1000]];
    
    cell.DLab.text = [NSString stringWithFormat:@"%@",[self.dataArr[indexPath.row]  valueForKey:@"description"]];
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
    NSDictionary *dic= self.dataArr[indexPath.row];
    AXWebViewController *webVC = [[AXWebViewController alloc] initWithAddress:[NSString stringWithFormat:@"%@/files/%@.%@",BASE_URL,dic[@"filePath"],dic[@"fileFrom"]]];
    webVC.title = @"详情页";
    [self.navigationController pushViewController:webVC animated:YES];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 11111;
    [btn setFrame:CGRectMake(WIDTH_ - 44, 27, 44, 30)];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [[UIApplication sharedApplication].delegate.window addSubview:btn];
    
    [btn setImage:[UIImage imageNamed:@"文章收藏icon_已收藏"] forState:UIControlStateNormal];
    
    UIView *vi = [UIView new];
    [vi setFrame:CGRectMake(0, 27, 100, 30)];
    vi.backgroundColor = [UIColor whiteColor];
    vi.tag = 33333;
    [[UIApplication sharedApplication].delegate.window addSubview:vi];
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake(0, 27, 44, 30)];
    btn1.tag = 22222;
    [btn1 setBackgroundColor:[UIColor whiteColor]];
    btn1.titleLabel.textAlignment = NSTextAlignmentRight;
    btn1.titleLabel.font = [UIFont systemFontOfSize:15];
    [[UIApplication sharedApplication].delegate.window addSubview:btn1];
    
    [btn1 setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    WS(ws);
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSMutableDictionary * mdict = [NSMutableDictionary new];
        [mdict setValue:ws.typeCode forKey:@"typeCode"];
        [mdict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"login"] forKey:@"userId"];
        [mdict setValue:dic[@"id"] forKey:@"lawId"];
        [ws POSTurl:CANCEL_FAVORITE parameters:@{@"data":[ws dictionaryToJson:mdict]} success:^(id responseObject) {
            
            [btn setImage:[UIImage imageNamed:@"文章收藏icon_未收藏"] forState:UIControlStateNormal];
            
            [[Toast shareToast]makeText:@"取消收藏成功" aDuration:1];
            
            [SVProgressHUD dismiss];
        } failure:^(id responseObject) {
            [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
            [SVProgressHUD dismiss];
        }];
    }];
    
    [[btn1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

        [ws.navigationController popViewControllerAnimated:YES];
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

@end
