//
//  HomeViewController.m
//  law-ios
//
//  Created by 刘磊 on 2018/1/27.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "HomeViewController.h"
#import "ChemistryVC.h"

#import "SDCycleScrollView.h"
#import "LawsViewController.h"
#import "SecurityViewController.h"


@interface HomeViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong)UIScrollView * bgScr;
@property (nonatomic, strong)SDCycleScrollView * cycleScrollView;

@property (nonatomic,strong)UIButton * lawsBtn;
@property (nonatomic,strong)UIButton * securityBtn;
@property (nonatomic,strong)UIButton * chemicalBtn;
@property (nonatomic,strong)UIButton * fireBtn;
@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)bindView {
    self.bgScr.frame = CGRectMake(0, 0, WIDTH_, HEIGHT_);
    [self.view addSubview:self.bgScr];
    
    [self.view addSubview:self.cycleScrollView];
    
    self.lawsBtn.frame = CGRectMake(0, self.cycleScrollView.bottom,WIDTH_ / 2, WIDTH_ / 2);
    [self.view addSubview:self.lawsBtn];
    self.securityBtn.frame = CGRectMake(WIDTH_ / 2, self.cycleScrollView.bottom,WIDTH_ / 2, WIDTH_ / 2);
    [self.view addSubview:self.securityBtn];
    self.chemicalBtn.frame = CGRectMake(0, self.lawsBtn.bottom,WIDTH_ / 2, WIDTH_ / 2);
    [self.view addSubview:self.chemicalBtn];
    self.fireBtn.frame = CGRectMake(WIDTH_ / 2, self.lawsBtn.bottom,WIDTH_ / 2, WIDTH_ / 2);
    [self.view addSubview:self.fireBtn];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, self.lawsBtn.bottom, WIDTH_, .5)];
    line.backgroundColor = LINE;
    [self.view addSubview:line];
    UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(self.lawsBtn.right, self.lawsBtn.top, 0.5, WIDTH_)];
    line1.backgroundColor = LINE;
    [self.view addSubview:line1];
    
    [self makeButton:self.securityBtn];
    [self makeButton:self.chemicalBtn];
    [self makeButton:self.fireBtn];
    [self makeButton:self.lawsBtn];
}

-(void)bindModel {
    self.cycleScrollView.localizationImageNamesGroup = @[@"img_banner1",@"img_banner2",@"img_banner3"];
}

-(void)bindAction {
    WS(ws);
    [[self.lawsBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [ws.navigationController pushViewController:[LawsViewController new] animated:YES];
    }];
    [[self.securityBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [ws.navigationController pushViewController:[SecurityViewController new] animated:YES];
        
    }];
    [[self.chemicalBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [ws.navigationController pushViewController:[ChemistryVC new] animated:YES];
    }];
    [[self.fireBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
}

#pragma mark - 加载数据
-(void)getData {
    [self POSTurl:@"http://baidu.com" parameters:nil success:^(id responseObject) {
        
    } failure:^(id responseObject) {
        
    }];
}

-(UIButton *)lawsBtn {
    if (!_lawsBtn) {
        UIButton * btn = [UIButton new];
        [btn setTitleColor:TEXT forState:UIControlStateNormal];
        [btn setTitle:@"法规标准库" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"ic_falv"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];

        
        _lawsBtn = btn;
    }
    return _lawsBtn;
}

-(UIButton *)securityBtn {
    if (!_securityBtn) {
        UIButton * btn = [UIButton new];
        [btn setTitleColor:TEXT forState:UIControlStateNormal];
        [btn setTitle:@"安检总局库" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"ic_ss"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _securityBtn = btn;
    }
    return _securityBtn;
}

-(UIButton *)chemicalBtn {
    if (!_chemicalBtn) {
        UIButton * btn = [UIButton new];
        [btn setTitleColor:TEXT forState:UIControlStateNormal];
        [btn setTitle:@"危险化学品" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"ic_wh"] forState:UIControlStateNormal];

        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];

        _chemicalBtn = btn;
    }
    return _chemicalBtn;
}

-(UIButton *)fireBtn {
    if (!_fireBtn) {
        UIButton * btn = [UIButton new];
        [btn setTitleColor:TEXT forState:UIControlStateNormal];
        [btn setTitle:@"防火间距" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"ic_fhjj"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];

        
        _fireBtn = btn;
    }
    return _fireBtn;
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

-(void)makeButton:(UIButton *)btn {
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height  + 30,-btn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setImageEdgeInsets:UIEdgeInsetsMake(- 10.0, 0.0,0.0, -btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
}
@end
