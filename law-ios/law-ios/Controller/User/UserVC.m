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
#import "CheckNewVC.h"
#import "AboutUsVC.h"
#import "perfectUserVC.h"
#import "AXWebViewController.h"
#import "DynamicDetailsViewController.h"

@interface UserVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong )UITableView *tvList;
@property (nonatomic, strong )NSArray *arrData;
@property (nonatomic, strong )NSDictionary *dicUser;

@end

@implementation UserVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"login"]) {
        [self refresh];
    }else{
        self.tabBarController.selectedIndex = 0;
        [self.navigationController pushViewController:[LoginVC new] animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)bindModel {
    self.arrData = @[@[@"我的"],@[@"个人资料",@"消息通知"],@[@"检查更新",@"关于我们",@"常见问题与帮助"],@[@"设置"]];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"login"]) {
        [self refresh];
    }
}

-(void)refresh{
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

-(void)bindView {
    self.title = @"我的";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tvList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,WIDTH_ ,HEIGHT_ -54) style:UITableViewStyleGrouped];
    self.tvList.delegate = self;
    self.tvList.dataSource = self;
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
            if (self.dicUser[@"head_icon"]) {
                NSString *imgurl = self.dicUser[@"head_icon"];
                imgurl=[imgurl stringByReplacingOccurrencesOfString:@"\\"withString:@"/"];
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@%@",BASE_URL,imgurl] forKey:@"imgurl"];
                cell.ivHead.layer.masksToBounds = YES;
                cell.ivHead.layer.cornerRadius = 32.5;
                NSString *urlString = [NSString stringWithFormat:@"%@%@",BASE_URL,imgurl];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:urlString]];
                UIImage *image = [UIImage imageWithData:data]; // 取得图片
                cell.ivHead.image = image;
            }
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
        perfectUserVC *vc = [perfectUserVC new];
        //vc.dicUser = self.dicUser;
        //self.arrKey = @[@[@"头像",@"real_name",@"license_type",@"id_no",@"sex",@"email"],@[@"name",@"departmentName",@"jobNmae",@"departmentName"]];
        if (self.dicUser) {
            vc.un = self.dicUser[@"real_name"];
            vc.uc = self.dicUser[@"id_no"];
            vc.ue = self.dicUser[@"email"];
            vc.Job = self.dicUser[@"name"];
            vc.Bm = self.dicUser[@"departmentName"];
            vc.Zw = self.dicUser[@"jobNmae"];
//            vc.Szd = self.dicUser[@"departmentName"];
            vc.department_id = self.dicUser[@"department_id"];
            vc.job_id = self.dicUser[@"job_id"];
            vc.company_id = self.dicUser[@"company_id"];
            vc.phone = self.dicUser[@"phone"];
        }
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section == 2&&indexPath.row == 0) {
        NSMutableDictionary * mdict = [NSMutableDictionary new];
        [mdict setValue:@"1" forKey:@"versionCode"];
        [self POSTurl:Check_Version parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
            NSString *st = responseObject[@"data"][@"versionInfo"];
            NSDictionary *dic = [self arrayWithJsonString:st];
            CheckNewVC *vc= [CheckNewVC new];
            vc.st = [NSString stringWithFormat:@"最新版本：%@",dic[@"versionName"]];
            vc.title = @"检查更新";
            [self.navigationController pushViewController:vc animated:YES];
            [SVProgressHUD dismiss];
            
        } failure:^(id responseObject) {
            [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
            [SVProgressHUD dismiss];
            
        }];
    }
    //#import "AboutUsVC.h"
    if (indexPath.section == 2&&indexPath.row == 1) {
        [self.navigationController pushViewController:[AboutUsVC new] animated:YES];
    }
    
    if (indexPath.section == 2&&indexPath.row == 2) {
        DynamicDetailsViewController *webVC = [[DynamicDetailsViewController alloc] init];
        webVC.urlStr = @"http://60.210.40.196:25018/law-server/qa.jsp";
        webVC.title = @"常见问题与帮助";
        [self.navigationController pushViewController:webVC animated:YES];
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
