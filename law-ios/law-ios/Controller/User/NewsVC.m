//
//  NewsVC.m
//  law-ios
//
//  Created by 李雪阳 on 2018/2/4.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "NewsVC.h"
#import "TypeButtonView.h"
#import "NewsCell.h"
#import "NewsDetailVC.h"

@interface NewsVC ()<TypeButtonActionDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong ) UITableView *tvList;
@property (nonatomic, strong ) NSArray *arrData;
@property (nonatomic, strong ) NSString *stType;
@end

@implementation NewsVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

-(void)getData {
    NSMutableDictionary * mdict = [NSMutableDictionary new];
//    [mdict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"login"] forKey:@"userId"];
    [mdict setValue:self.stType forKey:@"type"];
    WS(ws);
    [self POSTurl:GET_MESSAGE parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        NSString *st = responseObject[@"data"][@"messageList"];
        ws.arrData =  [self arrayWithJsonString:st];
        [ws.tvList reloadData];
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)bindModel{
    self.stType = @"1";
}

-(void)bindView {
    self.title = @"消息通知";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    TypeButtonView  *typeBtnView = [[TypeButtonView  alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    [typeBtnView setTypeButtonTitles:@[@"工作通知",@"系统通知"] withDownLableHeight:2 andDeleagte:self];
    [typeBtnView setTypeButtonNormalColor:RGBColor(153, 153, 153) andSelectColor:RGBColor(50, 154, 240)];
    typeBtnView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:typeBtnView];
    
    self.tvList = [[UITableView alloc]initWithFrame:CGRectMake(0, typeBtnView.bottom, WIDTH_, HEIGHT_ - typeBtnView.bottom)];
    self.tvList.delegate = self;
    self.tvList.dataSource = self;
    self.tvList.separatorStyle = UITableViewCellEditingStyleNone;
    self.tvList.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tvList];
}

-(void)didClickTypeButtonAction:(UIButton*)button withIndex:(NSInteger)index{
    
    if (index == 0) {
        self.stType = @"1";
    }else{
        self.stType = @"2";
    }
    [self getData];
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
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil];
    cell = [array objectAtIndex:0];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    NSDictionary *dic = self.arrData[indexPath.row];
    cell.lbTime.text = [self stDateToString1:dic[@"publishTime"]];
    cell.lb1.text = dic[@"title"];
    cell.lb2.text = dic[@"content"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NewsDetailVC.h
    NSDictionary *dic = self.arrData[indexPath.row];
    NewsDetailVC *vc = [NewsDetailVC new];
    vc.stTitle = dic[@"title"];
    vc.st1 = [NSString stringWithFormat:@"通知时间：%@",[self stDateToString1:dic[@"publishTime"]]];
    vc.st2 = [NSString stringWithFormat:@"发布单位：%@",dic[@"publishOrg"]];
    vc.st3 = [NSString stringWithFormat:@"发送部门：%@",dic[@"publishDepartment"]];
    vc.st5 = dic[@"content"];
    vc.title = @"通知";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
