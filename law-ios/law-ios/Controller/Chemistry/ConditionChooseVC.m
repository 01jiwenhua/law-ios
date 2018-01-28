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
    self.arrConditions = @[@"无气味",@"杏仁味",@"氨气味",@"无气味",@"杏仁味",@"氨气味",@"无气味",@"杏仁味",@"氨气味"];
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
    cell.textLabel.text = self.arrConditions[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate select:self.arrConditions[indexPath.row]];
}

@end
