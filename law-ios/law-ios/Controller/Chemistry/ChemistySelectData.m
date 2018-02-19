//
//  ChemistySelectData.m
//  law-ios
//
//  Created by 李雪阳 on 2018/1/31.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "ChemistySelectData.h"
#import "ChemistryModel.h"
#import "ChemistryDetailVC.h"

@interface ChemistySelectData ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong )UITableView *tvList;
@property (nonatomic, strong ) NSMutableArray *arrKnow;
@property (nonatomic, strong ) MJRefreshNormalHeader *refreshHeader;
@property (nonatomic, strong) MJRefreshBackNormalFooter * refreshFooter;
@property (nonatomic, assign) int currentPage;
@property (nonatomic, strong ) UIView *viHead;
@property (nonatomic, strong ) NSArray *arrName;
@property (nonatomic, strong ) NSArray *arrValue;
@end

@implementation ChemistySelectData

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrKnow = [NSMutableArray array];
    self.arrName = @[@"状态",@"颜色",@"气味",@"味道",@"比重（水=1）",@"比重（空气=1）",@"PH值",@"透明度"];
    self.arrValue = @[@"无",@"无色",@"无",@"无",@"无",@"无",@"无",@"无"];
    
}

-(void)bindView {
    self.title = @"查询结果";
    self.tvList = [UITableView new];
    self.tvList.delegate = self;
    self.tvList.dataSource = self;
    self.tvList.frame = CGRectMake(0, 0,WIDTH_ ,HEIGHT_);
    self.tvList.mj_header = self.refreshHeader;
    self.tvList.mj_footer = self.refreshFooter;
    [self.view addSubview:self.tvList];

    
    self.viHead = [UIView new];
    self.viHead.frame = CGRectMake(0, 0, WIDTH_, 260);
    self.viHead.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tvList.tableHeaderView = self.viHead;
    UILabel *lbT1 = [UILabel new];
    lbT1.frame = CGRectMake(20, 5, 200, 30);
    lbT1.text  =@"理化特性";
    lbT1.font = [UIFont systemFontOfSize:17];
    [self.viHead addSubview:lbT1];
    CGFloat y = lbT1.bottom + 5;
    for (int i=0 ; i<_arrKeyValue1.count; i++) {
        NSDictionary *dic= _arrKeyValue1[i];
        UILabel *lb = [UILabel new];
        lb.font = [UIFont systemFontOfSize:15];
        lb.textColor = [UIColor grayColor];
        lb.text = [NSString stringWithFormat:@"%@: %@",dic.allKeys[0],dic.allValues[0]];
        if (i%2==0) {
            lb.frame = CGRectMake(20, y, WIDTH_/2 - 20, 20);
        }else{
            lb.frame = CGRectMake(WIDTH_/2 +20, y, WIDTH_/2 - 20, 20);
            y = lb.bottom ;
        }
        [self.viHead addSubview:lb];
    }
    
    UILabel *lbT2 = [UILabel new];
    lbT2.frame = CGRectMake(20, y + 20, 200, 30);
    lbT2.text  =@"健康危害";
    lbT2.font = [UIFont systemFontOfSize:17];
    [self.viHead addSubview:lbT2];
    
    y = lbT2.bottom + 5;
    for (int i=0 ; i<_arrKeyValue2.count; i++) {
        NSDictionary *dic= _arrKeyValue2[i];
        UILabel *lb = [UILabel new];
        lb.font = [UIFont systemFontOfSize:15];
        lb.textColor = [UIColor grayColor];
        lb.text = [NSString stringWithFormat:@"%@: %@",dic.allKeys[0],dic.allValues[0]];
        if (i%2==0) {
            lb.frame = CGRectMake(20, y, WIDTH_/2 - 20, 20);
        }else{
            lb.frame = CGRectMake(WIDTH_/2 +20, y, WIDTH_/2 - 20, 20);
            y = lb.bottom ;
        }
        [self.viHead addSubview:lb];
    }
    
    self.viHead.frame = CGRectMake(0, 0, WIDTH_, y + 30);
    self.tvList.tableHeaderView = self.viHead;
    
}

-(void)getData{
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:[NSString stringWithFormat:@"%i",self.currentPage + 1] forKey:@"page"];
    [mdict setValue:@"15" forKey:@"pageSize"];
    if (self.dic) {
        [mdict addEntriesFromDictionary:self.dic];
    }
    
    [self POSTurl:GET_KNOWNLIST parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        NSString *st = responseObject[@"data"][@"chemicalsList"];
        NSArray *arr = [self arrayWithJsonString:st];
        if (ws.currentPage == 0) {
            [ws.arrKnow removeAllObjects];
        }
        for (NSDictionary *dic in arr) {
            ChemistryModel *model = [ChemistryModel yy_modelWithJSON:dic];
            [ws.arrKnow addObject:model];
        }
        [ws.tvList reloadData];
        [ws.tvList.mj_header endRefreshing];
        [ws.tvList.mj_footer endRefreshing];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrKnow.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    ChemistryModel *model = _arrKnow[indexPath.row];
    cell.textLabel.text = model.nameCn;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ChemistryModel *model = _arrKnow[indexPath.row];
    ChemistryDetailVC *vc =[ChemistryDetailVC new];
    vc.ID = model.id;
    vc.name = model.nameCn;
    vc.molecularFormula = model.molecularFormula;
    vc.ename = model.nameEn;
    vc.cas = model.cas;
    [self.navigationController pushViewController:vc animated:YES];
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
