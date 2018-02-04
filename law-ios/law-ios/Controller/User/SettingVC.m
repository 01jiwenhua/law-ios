//
//  SettingVC.m
//  law-ios
//
//  Created by 李雪阳 on 2018/2/3.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "SettingVC.h"
#import "NotificationVC.h"

@interface SettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong )UITableView *tvList;
@property (nonatomic, strong )NSArray *arrData;
@property (nonatomic, strong ) UIButton *btnLogOut;
@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)bindModel {
    self.arrData = @[@"通知管理",@"清除缓存"];
}

-(void)bindView {
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.title = @"设置";
    self.tvList = [[UITableView alloc]initWithFrame:CGRectMake(0, -20,WIDTH_ ,160) style:UITableViewStyleGrouped];
    self.tvList.delegate = self;
    self.tvList.dataSource = self;
    self.tvList.scrollEnabled = NO;
    [self.view addSubview:self.tvList];
    
    self.btnLogOut = [UIButton new];
    self.btnLogOut.frame = CGRectMake(0, self.tvList.bottom + 10, WIDTH_, 44);
    [self.btnLogOut setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.btnLogOut setBackgroundColor:[UIColor whiteColor]];
    [self.btnLogOut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:self.btnLogOut];
}

/**
 *  UITableViewDelegate
 *
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Celled";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.detailTextLabel.text = @"32M";
    }
    
    cell.textLabel.text = self.arrData[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
    
 
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[NotificationVC new] animated:YES];
    }
}


@end
