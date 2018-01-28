//
//  HomeViewController.m
//  law-ios
//
//  Created by 刘磊 on 2018/1/27.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "HomeViewController.h"
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
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
}

-(void)bindModel {
    WS(ws);
    [[self.lawsBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [ws.navigationController pushViewController:[LawsViewController new] animated:YES];
    }];
    [[self.securityBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [ws.navigationController pushViewController:[SecurityViewController new] animated:YES];

    }];
    [[self.chemicalBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
    [[self.fireBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
}

-(void)bindAction {
    
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
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:@"法规标准库" forState:UIControlStateNormal];
        
        
        _lawsBtn = btn;
    }
    return _lawsBtn;
}

-(UIButton *)securityBtn {
    if (!_securityBtn) {
        UIButton * btn = [UIButton new];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:@"安检总局库" forState:UIControlStateNormal];
        
        
        _securityBtn = btn;
    }
    return _securityBtn;
}

-(UIButton *)chemicalBtn {
    if (!_chemicalBtn) {
        UIButton * btn = [UIButton new];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:@"危险化学品" forState:UIControlStateNormal];
        
        
        _chemicalBtn = btn;
    }
    return _chemicalBtn;
}

-(UIButton *)fireBtn {
    if (!_fireBtn) {
        UIButton * btn = [UIButton new];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:@"防火间距" forState:UIControlStateNormal];
        
        
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
        SDCycleScrollView * sdc = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH_, 120) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        _cycleScrollView = sdc;
    }
    return _cycleScrollView;
}
@end
