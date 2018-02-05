//
//  perfectUserVC.m
//  law-ios
//
//  Created by 李雪阳 on 2018/2/3.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "perfectUserVC.h"
#import "UserHeadCell.h"
#import "UserPerfectCell.h"
#import "THScrollChooseView.h"

@interface perfectUserVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong )UITableView *tvList;
@property (nonatomic, strong )NSArray *arrData;
@property (nonatomic, strong )UIButton *btnFinish;


@property (nonatomic,strong)THScrollChooseView * scrollChooseView;

@property (nonatomic, strong)UITextField * UserName;
@property (nonatomic, strong)UITextField * UserCardNum;
@property (nonatomic, strong)UITextField * Useremail;

@end

@implementation perfectUserVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)bindView {
    self.title = @"补充个人信息";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tvList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,WIDTH_ ,HEIGHT_ - 150) style:UITableViewStyleGrouped];
    self.tvList.delegate = self;
    self.tvList.dataSource = self;
    [self.view addSubview:self.tvList];
    
    self.btnFinish = [[UIButton alloc]initWithFrame:CGRectMake(10, self.tvList.bottom + 15, WIDTH_ - 20, 50)];
    [self.btnFinish setBackgroundColor:BLUE];
    [self.btnFinish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnFinish addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btnFinish setTitle:@"完成注册" forState:UIControlStateNormal];
    [self.view addSubview:self.btnFinish];
}

-(void)bindModel {
    self.arrData = @[@[@"头像",@"姓名",@"证件类型",@"证件号码",@"性别",@"邮箱"],@[@"工作单位",@"部门",@"职务",@"所在地"]];
}

//完成注册
- (void)finishAction{
    NSString * phone = [[NSUserDefaults standardUserDefaults]valueForKey:@"phone"];
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:phone forKey:@"loginName"];
    [mdict setValue:@1 forKey:@"nickName"];
    [mdict setValue:self.UserName.text forKey:@"realName"];
    [mdict setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"DEPARTMENT_LIST%@",phone]] valueForKey:@"id"] forKey:@"departmentId"];
    [mdict setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"address%@",phone]]valueForKey:@"id"] forKey:@"regionId"];
    [mdict setValue:self.Useremail.text forKey:@"email"];
    [mdict setValue:self.UserCardNum.text forKey:@"idNo"];
    [mdict setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"GET_JOB_LIST%@",phone]] valueForKey:@"id"] forKey:@"jobId"];
    [mdict setValue:phone forKey:@"phone"];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"gender_Type_%@",phone]] isEqualToString:@"男"]) {
        [mdict setValue:@1 forKey:@"sex"];
    }else {
        [mdict setValue:@0 forKey:@"sex"];
    }
    [mdict setValue:@1 forKey:@"userType"];
    [mdict setValue:@1 forKey:@"licenseType"];
    [mdict setValue:[[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"companyList%@",phone]] valueForKey:@"name"] forKey:@"commpanyName"];
    [self POSTurl:REGIST parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        if ([responseObject[@"messageCode"] intValue] == 10000) {
            [self onBackAction];
        }else{
            [[Toast shareToast]makeText:@"信息不完整" aDuration:1];
        }
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
    
    return self.arrData.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *arr = self.arrData[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Celled";
    NSString * phone = [[NSUserDefaults standardUserDefaults]valueForKey:@"phone"];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UserHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"UserHeadCell" owner:self options:nil];
            cell = [array objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.textLabel.text = self.arrData[indexPath.section][indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row ==1||indexPath.row ==3||indexPath.row ==5) {
            UserPerfectCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"UserPerfectCell" owner:self options:nil];
            cell = [array objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.textLabel.text = self.arrData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            if (indexPath.row ==1) {
                if (self.UserName) {
                    cell.tfMessage.text = self.UserName.text;
                }
                self.UserName = cell.tfMessage;

            }
            if (indexPath.row ==3) {
                if (self.UserCardNum) {
                    cell.tfMessage.text = self.UserCardNum.text;
                }
                self.UserCardNum = cell.tfMessage;

            }
            if (indexPath.row ==5) {
                if (self.Useremail) {
                    cell.tfMessage.text = self.Useremail.text;
                }
                self.Useremail = cell.tfMessage;
                
            }
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = self.arrData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.detailTextLabel.textColor = [UIColor darkGrayColor];
            cell.detailTextLabel.text = @"请选择";
            if (indexPath.section == 0 && indexPath.row == 2) {
                if ([[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"Document_Type_%@",phone]]) {
                    cell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"Document_Type_%@",phone]];
                }
            }
            if (indexPath.section == 0 && indexPath.row == 4) {
                if ([[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"gender_Type_%@",phone]]) {
                    cell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"gender_Type_%@",phone]];
                }
            }
            return cell;
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    cell.textLabel.text = self.arrData[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    cell.detailTextLabel.text = @"请选择";
    if (indexPath.section == 1 && indexPath.row == 0) {
        if ([[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"companyList%@",phone]]) {
            cell.detailTextLabel.text = [[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"companyList%@",phone]] valueForKey:@"name"];
        }
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        if ([[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"DEPARTMENT_LIST%@",phone]]) {
            cell.detailTextLabel.text = [[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"DEPARTMENT_LIST%@",phone]] valueForKey:@"name"];
        }
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        if ([[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"GET_JOB_LIST%@",phone]]) {
            cell.detailTextLabel.text = [[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"GET_JOB_LIST%@",phone]] valueForKey:@"name"];
        }
    }
    if (indexPath.section == 1 && indexPath.row == 3) {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"address%@",phone]] valueForKey:@"name"]) {
            cell.detailTextLabel.text = [[[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"address%@",phone]] valueForKey:@"name"];
        }
    }
    
    return cell;
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 60;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.scrollChooseView) {
        [self.scrollChooseView removeFromSuperview];
        self.scrollChooseView = nil;
    }
    NSString * phone = [[NSUserDefaults standardUserDefaults]valueForKey:@"phone"];
    WS(ws);
    if (indexPath.section == 0 && indexPath.row == 2) {
        NSArray * arr = @[@"身份证"];
        self.scrollChooseView = [[THScrollChooseView alloc]initWithQuestionArray:arr withDefaultDesc:arr[0]];
        [self.scrollChooseView setConfirmBlock:^(NSInteger selectedValue) {
            [[NSUserDefaults standardUserDefaults]setObject:arr[selectedValue] forKey:[NSString stringWithFormat:@"Document_Type_%@",phone]];
            [ws.tvList reloadData];
        }];
        [self.scrollChooseView showView];
    }
    if (indexPath.section == 0 && indexPath.row == 4) {
        NSArray * arr = @[@"男",@"女"];
        self.scrollChooseView = [[THScrollChooseView alloc]initWithQuestionArray:arr withDefaultDesc:arr[0]];
        [self.scrollChooseView setConfirmBlock:^(NSInteger selectedValue) {
            [[NSUserDefaults standardUserDefaults]setObject:arr[selectedValue] forKey:[NSString stringWithFormat:@"gender_Type_%@",phone]];
            [ws.tvList reloadData];
        }];
        [self.scrollChooseView showView];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {

        [SVProgressHUD showWithStatus:@"加载中..."];
        [self POSTurl:GET_COMPANY_LIST parameters:@{@"data":[self dictionaryToJson:@{}]} success:^(id responseObject) {
            if ([responseObject[@"messageCode"] intValue] == 10000) {
                NSArray * companyList = [ws arrayWithJsonString:responseObject[@"data"][@"companyList"]];
                NSMutableArray * arr = [NSMutableArray new];
                for (id obj in companyList) {
                    [arr addObject:[NSString stringWithFormat:@"%@",[obj valueForKey:@"name"]]];
                }
                ws.scrollChooseView = [[THScrollChooseView alloc]initWithQuestionArray:arr withDefaultDesc:arr[0]];
                [ws.scrollChooseView setConfirmBlock:^(NSInteger selectedValue) {
                    [[NSUserDefaults standardUserDefaults]setObject:companyList[selectedValue] forKey:[NSString stringWithFormat:@"companyList%@",phone]];
                    [ws.tvList reloadData];
                }];
                [ws.scrollChooseView showView];
            }
            [SVProgressHUD dismiss];
        } failure:^(id responseObject) {
            [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
            [SVProgressHUD dismiss];
        }];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        NSDictionary * dict = [[NSUserDefaults standardUserDefaults] valueForKey:[NSString stringWithFormat:@"companyList%@",phone]];
        if (!dict) {
            [[Toast shareToast]makeText:@"请选择工作单位" aDuration:2];
            return ;
        }
        [SVProgressHUD showWithStatus:@"加载中..."];
        NSMutableDictionary * mdict = [NSMutableDictionary new];
        [mdict setValue:dict[@"id"] forKey:@"companyId"];
        [self POSTurl:GET_DEPARTMENT_LIST parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
            if ([responseObject[@"messageCode"] intValue] == 10000) {
                NSArray * departmentList = [ws arrayWithJsonString:responseObject[@"data"][@"departmentList"]];
                NSMutableArray * arr = [NSMutableArray new];
                for (id obj in departmentList) {
                    [arr addObject:[NSString stringWithFormat:@"%@",[obj valueForKey:@"name"]]];
                }
                ws.scrollChooseView = [[THScrollChooseView alloc]initWithQuestionArray:arr withDefaultDesc:arr[0]];
                [ws.scrollChooseView setConfirmBlock:^(NSInteger selectedValue) {
                    [[NSUserDefaults standardUserDefaults]setObject:departmentList[selectedValue] forKey:[NSString stringWithFormat:@"DEPARTMENT_LIST%@",phone]];
                    [ws.tvList reloadData];
                }];
                [ws.scrollChooseView showView];
            }
            [SVProgressHUD dismiss];
        } failure:^(id responseObject) {
            [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
            [SVProgressHUD dismiss];
        }];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        [SVProgressHUD showWithStatus:@"加载中..."];
        NSMutableDictionary * mdict = [NSMutableDictionary new];
        [self POSTurl:GET_JOB_LIST parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
            if ([responseObject[@"messageCode"] intValue] == 10000) {
                NSArray * jobList = [ws arrayWithJsonString:responseObject[@"data"][@"jobList"]];
                NSMutableArray * arr = [NSMutableArray new];
                for (id obj in jobList) {
                    [arr addObject:[NSString stringWithFormat:@"%@",[obj valueForKey:@"name"]]];
                }
                ws.scrollChooseView = [[THScrollChooseView alloc]initWithQuestionArray:arr withDefaultDesc:arr[0]];
                [ws.scrollChooseView setConfirmBlock:^(NSInteger selectedValue) {
                    [[NSUserDefaults standardUserDefaults]setObject:jobList[selectedValue] forKey:[NSString stringWithFormat:@"GET_JOB_LIST%@",phone]];
                    [ws.tvList reloadData];
                }];
                [ws.scrollChooseView showView];
            }
            [SVProgressHUD dismiss];
        } failure:^(id responseObject) {
            [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
            [SVProgressHUD dismiss];
        }];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 3) {

        NSArray * addressList = @[@{@"name":@"北京市东城区",
                                @"id":@"1"
                                }];
        NSMutableArray * arr = [NSMutableArray new];
        for (id obj in addressList) {
            [arr addObject:[NSString stringWithFormat:@"%@",[obj valueForKey:@"name"]]];
        }
        self.scrollChooseView = [[THScrollChooseView alloc]initWithQuestionArray:arr withDefaultDesc:arr[0]];
        [self.scrollChooseView setConfirmBlock:^(NSInteger selectedValue) {
            [[NSUserDefaults standardUserDefaults]setObject:addressList[selectedValue] forKey:[NSString stringWithFormat:@"address%@",phone]];
            [ws.tvList reloadData];
        }];
        [self.scrollChooseView showView];
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
