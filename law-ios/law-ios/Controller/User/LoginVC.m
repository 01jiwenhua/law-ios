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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
}

-(void)bindView {
    self.btnRegist.layer.borderColor = BLUE.CGColor;
    self.btnRegist.layer.borderWidth = 0.7;
    self.btnRegist.layer.masksToBounds = YES;
    self.btnRegist.layer.cornerRadius = 7;
    [self.btnLogin setBackgroundColor:BLUE];
    self.btnLogin.layer.cornerRadius = 7;
}

-(void)bindAction {
    WS(ws);
    [[self.codeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [ws getCode];
    }];
    
    [[self.btnLogin rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [ws Login];
    }];
}


-(void)getCode {
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:self.tfPhone.text forKey:@"phone"];
    [self POSTurl:GET_VERIFYCODE parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        if ([responseObject[@"messageCode"] intValue] == 10000) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (ws) {
                    
                }
            });
        }
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
    }];
}

-(void)Login {
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:self.tfPhone.text forKey:@"phone"];
    [mdict setValue:self.tfCode.text forKey:@"verifyCode"];
    [self POSTurl:LOGIN parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        if ([responseObject[@"messageCode"] intValue] == 10000) {
            [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"login"];
        }
        [[Toast shareToast]makeText:[NSString stringWithFormat:@"%@",responseObject[@"message"]] aDuration:2];
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
    }];
}
@end
