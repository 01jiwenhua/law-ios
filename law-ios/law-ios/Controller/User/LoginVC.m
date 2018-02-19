//
//  LoginVC.m
//  law-ios
//
//  Created by xueyang.li on 2018/2/1.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"

@interface LoginVC ()
@property (nonatomic, strong) NSTimer * validationTimer;
@property (nonatomic, assign) int validationSurplusTime;

@end

@implementation LoginVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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
    
    [[self.btnRegist rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [ws.navigationController pushViewController:[NSClassFromString(@"RegisterVC") new] animated:YES];
    }];
}


-(void)getCode {
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:self.tfPhone.text forKey:@"phone"];
    [self POSTurl:GET_VERIFYCODE parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        if ([responseObject[@"messageCode"] intValue] == 10000) {
            [[Toast shareToast]makeText:@"验证码发送成功" aDuration:1];
             [self validationButAction];
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
            NSString *st = responseObject[@"data"][@"userInfo"];
            NSDictionary *dic = [self arrayWithJsonString:st];
            [[NSUserDefaults standardUserDefaults]setObject:dic[@"id"] forKey:@"login"];
            [[NSUserDefaults standardUserDefaults]setObject:ws.tfPhone.text forKey:@"phone"];
            [ws onBackAction];
        }
        [[Toast shareToast]makeText:[NSString stringWithFormat:@"%@",responseObject[@"message"]] aDuration:2];
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
    }];
}

- (void)validationButAction {
    
    self.codeBtn.userInteractionEnabled = NO;
    self.validationSurplusTime = 60;
    [self.codeBtn setTitle:[NSString stringWithFormat:@"%d秒后重发",self.validationSurplusTime] forState:UIControlStateNormal];
    [_validationTimer invalidate];
    _validationTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateVerificatetime) userInfo:nil repeats:YES];
    
}

/**
 *  更新验证码时间
 */
-(void)updateVerificatetime {
    
    self.validationSurplusTime --;
    [self.codeBtn setTitle:[NSString stringWithFormat:@"%d秒后重发",self.validationSurplusTime] forState:UIControlStateNormal];
    if (self.validationSurplusTime == 0) {
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_validationTimer invalidate];
        self.codeBtn.userInteractionEnabled = YES;
    }
}
@end
