//
//  LawsViewController.m
//  law-ios
//
//  Created by 刘磊 on 2018/1/28.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "LawsViewController.h"
#import "SDCycleScrollView.h"
#import "SearchViewController.h"

@interface LawsViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong)UIScrollView * bgScr;
@property (nonatomic, strong)SDCycleScrollView * cycleScrollView;

@end

@implementation LawsViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"法规标准库";
    self.bgScr.frame = CGRectMake(0, 0, WIDTH_, HEIGHT_ - 64);
    [self.view addSubview:self.bgScr];
    
    [self.view addSubview:self.cycleScrollView];
    
    NSArray * titles = @[@"法律",@"法规",@"标准"];
    UIButton * btn;
    UIImageView * igv;
    UIView * line;
    for (int i = 0; i < 3; i ++) {
        btn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.cycleScrollView.bottom+ 44 *i, WIDTH_, 44)];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [self.bgScr addSubview:btn];
        
        igv = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_ - 16, 15, 7, 13)];
        igv.image = [UIImage imageNamed:@"Back Chevron Copy 4"];
        [btn addSubview:igv];
        
        line = [[UIView alloc]initWithFrame:CGRectMake(13, 43, WIDTH_, 0.5)];
        [btn addSubview:line];
        
        WS(ws);
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [ws.navigationController pushViewController:[SearchViewController new] animated:YES];
        }];
    }
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
        SDCycleScrollView * sdc = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH_, 120) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        _cycleScrollView = sdc;
    }
    return _cycleScrollView;
}
@end
