//
//  LoginVC.m
//  law-ios
//
//  Created by xueyang.li on 2018/2/1.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)bindView {
    self.btnRegist.layer.borderColor = BLUE.CGColor;
    self.btnRegist.layer.borderWidth = 0.7;
    self.btnRegist.layer.masksToBounds = YES;
    self.btnRegist.layer.cornerRadius = 7;
    [self.btnLogin setBackgroundColor:BLUE];
    self.btnLogin.layer.cornerRadius = 7;
}

@end
