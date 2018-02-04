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

@interface NewsVC ()<TypeButtonActionDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong ) UITableView *tvList;
@end

@implementation NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
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
        
    }else{
        
    }
}

/**
 *  UITableViewDelegate
 *
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Celled";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil];
    cell = [array objectAtIndex:0];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
