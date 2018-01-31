//
//  ChemistySelectData.m
//  law-ios
//
//  Created by 李雪阳 on 2018/1/31.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "ChemistySelectData.h"
#import "ChemistryModel.h"

@interface ChemistySelectData ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong )UITableView *tvList;
@property (nonatomic, strong ) NSMutableArray *arrKnow;
@property (nonatomic, strong ) MJRefreshNormalHeader *refreshHeader;
@property (nonatomic, strong) MJRefreshBackNormalFooter * refreshFooter;
@property (nonatomic, assign) int currentPage;
@end

@implementation ChemistySelectData

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrKnow = [NSMutableArray array];
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
