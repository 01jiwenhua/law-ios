//
//  SecurityViewController.m
//  law-ios
//
//  Created by 刘磊 on 2018/1/28.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "SecurityViewController.h"
#import "SDCycleScrollView.h"
#import "SearchTypeViewController.h"

@interface SecurityViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong)UIScrollView * bgScr;
@property (nonatomic, strong)SDCycleScrollView * cycleScrollView;
@property (nonatomic, strong)UIImageView * headIgv;
@end

@implementation SecurityViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"安全标准库";
    self.bgScr.frame = CGRectMake(0, 0, WIDTH_, HEIGHT_ - 64);
    [self.view addSubview:self.bgScr];
    
    [self.view addSubview:self.cycleScrollView];
    
    self.headIgv.frame = CGRectMake(13, self.cycleScrollView.bottom + 10, 70, 16);
    [self.bgScr addSubview:self.headIgv];
    
    NSArray * titles = @[@"化学危险品监管",@"烟花爆竹"];
    NSArray * titles1 = @[@"包含;化工(含石油化工)、医药、非药品类易制毒化学品",@""];
    NSArray * imgmArr= @[@"img_wh",@"img_yh"];
    UIButton * btn;
    UILabel * lab1;
    UILabel * lab2;
    UIImageView * igv1;
    UIImageView * igv2;
    UIView * line;
    for (int i = 0; i < 2; i ++) {
        btn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.headIgv.bottom+ 20+ 80 *i, WIDTH_, 80)];
        [self.bgScr addSubview:btn];
        lab1 = [UILabel new];
        lab1.frame = CGRectMake(120, 10, WIDTH_ - 120, 20);
        lab1.font = [UIFont systemFontOfSize:14.f];
        lab1.textColor = TEXT;
        lab1.text = titles[i];
        [btn addSubview:lab1];
        
        lab2 = [UILabel new];
        lab2.frame = CGRectMake(120, 40, WIDTH_ - 150, 30);
        lab2.font = [UIFont systemFontOfSize:12.f];
        lab2.numberOfLines = 0;
        lab2.text = titles1[i];
        lab2.textColor = [UIColor grayColor];
        [btn addSubview:lab2];
        
        igv1 = [[UIImageView alloc]initWithFrame:CGRectMake(13, 10, 100, 60)];
        igv1.image = [UIImage imageNamed:imgmArr[i]];
        [btn addSubview:igv1];
        
        igv2 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_ - 16, 30, 7, 13)];
        igv2.image = [UIImage imageNamed:@"Back Chevron Copy 4"];
        [btn addSubview:igv2];
        
        line = [[UIView alloc]initWithFrame:CGRectMake(13, 79, WIDTH_, 0.5)];
        line.backgroundColor = LINE;
        [btn addSubview:line];
        
        WS(ws);
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [ws.navigationController pushViewController:[SearchTypeViewController new] animated:YES];
        }];
    }
}

-(void)bindModel {
    self.cycleScrollView.localizationImageNamesGroup = @[@"img_banner1",@"img_banner2",@"img_banner3"];
    
}

-(UIScrollView *)bgScr {
    if (!_bgScr) {
        UIScrollView * scr = [UIScrollView new];
        
        _bgScr = scr;
    }
    return _bgScr;
}


-(SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        SDCycleScrollView * sdc = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH_, 150) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        _cycleScrollView = sdc;
    }
    return _cycleScrollView;
}

-(UIImageView *)headIgv {
    if (!_headIgv) {
        UIImageView * igv = [UIImageView new];
        igv.image = [UIImage imageNamed:@"img_select_divder"];
        
        
        UIView * line = [UIView new];
        line.backgroundColor = RGBColor(133, 205, 201);
        line.frame = CGRectMake(10, 14.5, WIDTH_, 1.5);
        [igv addSubview:line];
        
        _headIgv = igv;
    }
    return _headIgv;
}
@end
