//
//  UserVC.m
//  law-ios
//
//  Created by 李雪阳 on 2018/2/1.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "UserVC.h"
#import "MyHeadCell.h"
#import "MyInfoCell.h"
#import "LoginTableViewCell.h"
#import "LoginVC.h"
#import "SettingVC.h"
#import "NewsVC.h"
#import "UserInfoVC.h"

@interface UserVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong )UITableView *tvList;
@property (nonatomic, strong )NSArray *arrData;
@property (nonatomic, strong )NSDictionary *dicUser;

@end

@implementation UserVC

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)bindModel {
    self.arrData = @[@[@"我的"],@[@"个人资料",@"消息通知"],@[@"检查更新",@"关于我们",@"常见问题与帮助"],@[@"设置"]];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"login"]) {
        [SVProgressHUD showWithStatus:@"加载中..."];
        NSMutableDictionary * mdict = [NSMutableDictionary new];
        [mdict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"login"] forKey:@"userId"];
        WS(ws);
        [self POSTurl:USER_URL parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
            NSString *st = responseObject[@"data"][@"userInfo"];
            ws.dicUser = [self arrayWithJsonString:st];
            [ws.tvList reloadData];
            [SVProgressHUD dismiss];
        } failure:^(id responseObject) {
            [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
            [SVProgressHUD dismiss];
        }];
    }
}

-(void)bindView {
    self.tvList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,WIDTH_ ,HEIGHT_) style:UITableViewStyleGrouped];
    self.tvList.delegate = self;
    self.tvList.dataSource = self;
    self.tvList.frame = CGRectMake(0, 0,WIDTH_ ,HEIGHT_);
    [self.tvList registerClass:[LoginTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LoginTableViewCell class])];

    [self.view addSubview:self.tvList];
}

/**
 *  UITableViewDelegate
 *
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.arrData.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *arr = self.arrData[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Celled";
    if (indexPath.section == 0) {
        
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"login"]) {
            MyHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyHeadCell" owner:self options:nil];
            cell = [array objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.lbShow.text = self.dicUser[@"jobNmae"];
            cell.lbName.text = self.dicUser[@"real_name"];
            return cell;
        }else {
            LoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoginTableViewCell" forIndexPath:indexPath];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
    }
    
    MyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MyInfoCell" owner:self options:nil];
    cell = [array objectAtIndex:0];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.lbText.text = self.arrData[indexPath.section][indexPath.row];
    cell.ivIcon.image = [UIImage imageNamed:self.arrData[indexPath.section][indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 128;
    }
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (![[NSUserDefaults standardUserDefaults] valueForKey:@"login"]) {
            [self.navigationController pushViewController:[LoginVC new] animated:YES];
        }
    }
    
    if (indexPath.section == 3) {
        [self.navigationController pushViewController:[SettingVC new] animated:YES];
    }
    
    if (indexPath.section == 1&&indexPath.row == 1) {
        [self.navigationController pushViewController:[NewsVC new] animated:YES];
    }
    
    if (indexPath.section == 1&&indexPath.row == 0) {
        UserInfoVC *vc = [UserInfoVC new];
        vc.dicUser = self.dicUser;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//section头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 2 ;
}

//section头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 4 ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
@end
