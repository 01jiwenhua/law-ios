//
//  HomeViewController.m
//  law-ios
//
//  Created by 刘磊 on 2018/1/27.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (nonatomic,strong)UIButton * chemicalBtn;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
}
-(void)bindView {
    self.chemicalBtn.frame = CGRectMake(0, 200,WIDTH_ / 2, WIDTH_ / 2);
    [self.view addSubview:self.chemicalBtn];
}

-(void)bindModel {
    WS(ws);
    [[self.chemicalBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
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

-(UIButton *)chemicalBtn {
    if (!_chemicalBtn) {
        UIButton * btn = [UIButton new];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn setTitle:@"化学" forState:UIControlStateNormal];
        
        
        _chemicalBtn = btn;
    }
    return _chemicalBtn;
}
@end
