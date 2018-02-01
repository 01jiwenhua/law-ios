//
//  ListViewController.m
//  law-ios
//
//  Created by 刘磊 on 2018/2/1.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "ListViewController.h"
#import "ListTableViewCell.h"

@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tbv;
@property (nonatomic,strong)NSMutableArray * dataArr;

@property (nonatomic,assign)int page;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.page = 0;
    
    self.tbv.frame = CGRectMake(0, 0, WIDTH_, HEIGHT_ - 108);
    [self.view addSubview:self.tbv];
}

-(void)getData{
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:self.level forKey:@"level"];
    [mdict setValue:[NSNumber numberWithInt:self.page + 1] forKey:@"page"];
    [mdict setValue:@10 forKey:@"pageSize"];
    
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
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ListTableViewCell" forIndexPath:indexPath];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
-(UITableView *)tbv {
    if (!_tbv) {
        UITableView * tbv = [UITableView new];
        [tbv registerClass:[ListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ListTableViewCell class])];
        tbv.delegate = self;
        tbv.dataSource = self;
        
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
