//
//  ChemistySCVC.m
//  law-ios
//
//  Created by 李雪阳 on 2018/2/6.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "ChemistySCVC.h"
#import "ChemistryModel.h"
#import "ChemistryDetailVC.h"

@interface ChemistySCVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong ) UITableView *tvList;
@property (nonatomic, strong ) MJRefreshNormalHeader *refreshHeader;
@property (nonatomic, strong) MJRefreshBackNormalFooter * refreshFooter;
@property (nonatomic, assign) int currentPage;
@property (nonatomic, strong )NSMutableArray *arrDate;

@end

@implementation ChemistySCVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)bindModel {
    self.arrDate = [NSMutableArray array];
}

-(void)getData {
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"login"] forKey:@"userId"];
    [mdict setValue:@"wxhxp" forKey:@"typeCode"];
    [mdict setValue:[NSString stringWithFormat:@"%i",self.currentPage + 1] forKey:@"page"];
    [mdict setValue:@"10" forKey:@"pageSize"];
    
    [self POSTurl:GET_FavoriteList parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        NSString *st = responseObject[@"data"][@"favoriteList"];
        [ws.arrDate addObjectsFromArray:[self arrayWithJsonString:st]];
        [ws.tvList reloadData];
        [SVProgressHUD dismiss];
        [ws.tvList.mj_header endRefreshing];
        [ws.tvList.mj_footer endRefreshing];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
        [ws.tvList.mj_header endRefreshing];
        [ws.tvList.mj_footer endRefreshing];
    }];
}

-(void)bindView {
    self.tvList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_, HEIGHT_ - 108)];
    self.tvList.delegate = self;
    self.tvList.dataSource = self;
    self.tvList.mj_header = self.refreshHeader;
    self.tvList.mj_footer = self.refreshFooter;
    [self.view addSubview:self.tvList];
}

/**
 *  UITableViewDelegate
 *
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrDate.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [NSString stringWithFormat:@"%li-%li",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
    NSDictionary *dic = self.arrDate[indexPath.row];
    cell.textLabel.text = dic[@"nameCn"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.arrDate[indexPath.row];
    ChemistryDetailVC *vc =[ChemistryDetailVC new];
    vc.ID = dic[@"id"];
    vc.name = dic[@"nameCn"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//section头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 4;
}

//section头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 4 ;
}

-(MJRefreshNormalHeader *)refreshHeader {
    if (!_refreshHeader) {
        WS(ws);
        _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            ws.currentPage = 0;
            [self getData];
        }];
        _refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    }
    return _refreshHeader;
}

-(MJRefreshBackNormalFooter *)refreshFooter {
    if (!_refreshFooter){
        WS(ws);
        _refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            ws.currentPage ++;
            [self getData];
        }];
    }
    return _refreshFooter;
}
@end
