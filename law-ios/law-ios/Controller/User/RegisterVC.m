//
//  RegisterVC.m
//  law-ios
//
//  Created by 李雪阳 on 2018/2/3.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfCode;

@end

@implementation RegisterVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)bindView {
    self.btnNext.layer.cornerRadius = 7;
    self.btnNext.layer.masksToBounds = YES;
    self.title = @"注册";
}

//获取验证码
- (IBAction)getCodeAction:(id)sender {
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:self.tfPhone.text forKey:@"phone"];
    [self POSTurl:GET_VERIFYCODE parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        if ([responseObject[@"messageCode"] intValue] == 10000) {
        }
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
    }];
}

//下一步
- (IBAction)nextAction:(id)sender {
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:self.tfPhone.text forKey:@"phone"];
    [mdict setValue:self.tfCode.text forKey:@"verifyCode"];
    [self POSTurl:CHECK_REGIST parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        if ([responseObject[@"messageCode"] intValue] == 10000) {
            [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"login"];
            
            [ws.navigationController pushViewController:[NSClassFromString(@"perfectUserVC") new] animated:YES];
            
            NSMutableArray * arr = [ws.navigationController viewControllers].mutableCopy;
            NSInteger count = arr.count;
            if (count > 2) {
                [arr removeObjectAtIndex:count - 2];
            }
            self.navigationController.viewControllers = arr;
            [[NSUserDefaults standardUserDefaults]setObject:ws.tfPhone.text forKey:@"phone"];
        }
        [[Toast shareToast]makeText:[NSString stringWithFormat:@"%@",responseObject[@"message"]] aDuration:2];
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
    }];
}

@end
