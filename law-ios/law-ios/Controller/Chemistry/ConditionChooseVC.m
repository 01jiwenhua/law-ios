//
//  conditionChooseVC.m
//  law-ios
//
//  Created by 李雪阳 on 2018/1/28.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "ConditionChooseVC.h"

@interface ConditionChooseVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong ) UITableView *tvList;
@property (nonatomic, strong ) NSArray *arrConditions;
@end

@implementation ConditionChooseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)bindView{
    self.title = @"条件筛选";
    self.tvList = [[UITableView alloc]initWithFrame:CGRectMake(0, -30, WIDTH_, HEIGHT_)style:UITableViewStyleGrouped];
    self.tvList.delegate = self;
    self.tvList.dataSource = self;
    [self.view addSubview:self.tvList];
}

-(void)bindModel{
    self.arrConditions = [NSArray new];
}

-(void)getData{
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    
    [mdict setValue:self.code forKey:@"code"];
    [self POSTurl:GET_UNKNOWPARAMS_DETAILS parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        NSString *st = responseObject[@"data"][@"list"];
        ws.arrConditions = [self arrayWithJsonString:st];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrConditions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = self.arrConditions[indexPath.row][@"name"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate select:self.arrConditions[indexPath.row]];
}

@end
