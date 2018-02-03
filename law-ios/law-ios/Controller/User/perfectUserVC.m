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

@interface perfectUserVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong )UITableView *tvList;
@property (nonatomic, strong )NSArray *arrData;
@property (nonatomic, strong )UIButton *btnFinish;
@end

@implementation perfectUserVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
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
    self.arrData = @[@[@"头像",@"姓名",@"证件类型",@"证件号码",@"性别邮箱"],@[@"工作单位",@"部门",@"职务",@"所在地"]];
}

//完成注册
- (void)finishAction{
    
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
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = self.arrData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.detailTextLabel.textColor = [UIColor darkGrayColor];
            cell.detailTextLabel.text = @"请选择";
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
    return cell;
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 60;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
