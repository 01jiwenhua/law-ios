//
//  UserInfoVC.m
//  law-ios
//
//  Created by 李雪阳 on 2018/2/4.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "UserInfoVC.h"
#import "UserHeadCell.h"

@interface UserInfoVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong )UITableView *tvList;
@property (nonatomic, strong )NSArray *arrData;
@property (nonatomic, strong )NSArray *arrKey;

@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)bindView{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tvList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,WIDTH_ ,HEIGHT_ ) style:UITableViewStyleGrouped];
    self.tvList.delegate = self;
    self.tvList.dataSource = self;
    [self.view addSubview:self.tvList];
}

-(void)bindModel {
    self.arrData = @[@[@"头像",@"姓名",@"证件类型",@"证件号码",@"性别",@"邮箱"],@[@"工作单位",@"部门",@"职务",@"所在地"]];
    self.arrKey = @[@[@"头像",@"real_name",@"license_type",@"id_no",@"sex",@"email"],@[@"name",@"departmentName",@"jobNmae",@"departmentName"]];
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
    if (indexPath.section == 0 &&indexPath.row == 0) {
            UserHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"UserHeadCell" owner:self options:nil];
            cell = [array objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.textLabel.text = self.arrData[indexPath.section][indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.arrData[indexPath.section][indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    
        NSString *key = self.arrKey[indexPath.section][indexPath.row];
    if ([self.dicUser[key] isKindOfClass:[NSString class]]) {
        cell.detailTextLabel.text = self.dicUser[key];
    }
    if (indexPath.section==0  && indexPath.row == 2) {
        cell.detailTextLabel.text = @"身份证";
    }
    if (indexPath.section==0  && indexPath.row == 4) {
        if ([self.dicUser[@"sex"]intValue] == 1) {
            cell.detailTextLabel.text = @"男";
        }else{
            cell.detailTextLabel.text = @"女";
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

@end
