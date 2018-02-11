//
//  FireListVC.m
//  law-ios
//
//  Created by 刘磊 on 2018/2/7.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "FireListVC.h"

@interface FireListVC ()
@property (nonatomic, strong)UIScrollView * bgScr;

@end

@implementation FireListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.bgScr.frame = CGRectMake(0, 0, WIDTH_, HEIGHT_ - 108);
    [self.view addSubview:self.bgScr];
    
    NSArray * titles = @[@"GB50016-2014\n建筑设计防火规范",@"GB50160-2008\n石油化工企业设计防火规范",@"汽油加油加气站设计与施工规范"];
    NSArray * imgArr = @[@"建筑规范图片",@"化工规范图片",@"加油站设计规范图片"];
    UIButton * btn;
    UIImageView * igv;
    UIView * line;
    UILabel * lab;
    for (int i = 0; i < 3; i ++) {
        btn = [[UIButton alloc]initWithFrame:CGRectMake(9,103 *i, WIDTH_, 103)];
        [self.bgScr addSubview:btn];
        
        igv = [[UIImageView alloc]initWithFrame:CGRectMake(20, 14, 100, 75)];
        igv.image = [UIImage imageNamed:imgArr[i]];
        igv.backgroundColor = RGBColor(arc4random()%255, arc4random()%255, arc4random()%255);
        [btn addSubview:igv];
        
        line = [[UIView alloc]initWithFrame:CGRectMake(0, 103, WIDTH_, 0.5)];
        line.backgroundColor = LINE;
        [btn addSubview:line];
        
        lab = [UILabel new];
        lab.text = titles[i];
        if (i == 2) {
            lab.text = @"GB50156-2012\n汽油加油加气站设计与施工规范";
        }
        lab.numberOfLines = 0;
        lab.font = [UIFont systemFontOfSize:18.f];
        lab.textColor = RGBColor(42, 42, 48);
        lab.frame = CGRectMake(134, 0, WIDTH_ - 144, btn.height);
        [btn addSubview:lab];
        
        WS(ws);
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            UIViewController * vc = [NSClassFromString(@"FireSeachVC") new];
            vc.title = titles[i];
            
            [ws.navigationController pushViewController:vc animated:YES];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIScrollView *)bgScr {
    if (!_bgScr) {
        UIScrollView * scr = [UIScrollView new];
        
        _bgScr = scr;
    }
    return _bgScr;
}

@end
