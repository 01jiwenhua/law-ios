//
//  preventFireVC.m
//  law-ios
//
//  Created by 李雪阳 on 2018/2/5.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "preventFireVC.h"
#import "TypeButtonView.h"

@interface preventFireVC ()<TypeButtonActionDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong ) UITableView *tvList;
@end

@implementation preventFireVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)bindView{
    self.title = @"防火间距";
    TypeButtonView  *typeBtnView = [[TypeButtonView  alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    [typeBtnView setTypeButtonTitles:@[@"标准查询",@"模糊查询"] withDownLableHeight:2 andDeleagte:self];
    [typeBtnView setTypeButtonNormalColor:RGBColor(153, 153, 153) andSelectColor:RGBColor(50, 154, 240)];
    typeBtnView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:typeBtnView];
}

@end
