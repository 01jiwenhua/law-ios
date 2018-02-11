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
@property (nonatomic, strong) NSTimer * validationTimer;
@property (nonatomic, assign) int validationSurplusTime;
@property (weak, nonatomic) IBOutlet UIButton *btnGetCode;

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
    if (self.st) {
        self.title = self.st;
        [self.btnNext setTitle:@"修改" forState:UIControlStateNormal];
    }
}

//获取验证码
- (IBAction)getCodeAction:(id)sender {
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:self.tfPhone.text forKey:@"phone"];
    [self POSTurl:GET_VERIFYCODE parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        if ([responseObject[@"messageCode"] intValue] == 10000) {
            [self validationButAction];
        }
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
    }];
}

- (void)validationButAction {
    
    self.btnGetCode.userInteractionEnabled = NO;
    self.validationSurplusTime = 60;
    [self.btnGetCode setTitle:[NSString stringWithFormat:@"%d秒后重发",self.validationSurplusTime] forState:UIControlStateNormal];
    [_validationTimer invalidate];
    _validationTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateVerificatetime) userInfo:nil repeats:YES];
    
}

/**
 *  更新验证码时间
 */
-(void)updateVerificatetime {
    
    self.validationSurplusTime --;
    [self.btnGetCode setTitle:[NSString stringWithFormat:@"%d秒后重发",self.validationSurplusTime] forState:UIControlStateNormal];
    if (self.validationSurplusTime == 0) {
        [self.btnGetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_validationTimer invalidate];
        self.btnGetCode.userInteractionEnabled = YES;
    }
}

//下一步
- (IBAction)nextAction:(id)sender {
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:self.tfPhone.text forKey:@"phone"];
    [mdict setValue:self.tfCode.text forKey:@"verifyCode"];
    NSString *sturl = CHECK_REGIST;
    if (self.st) {
        sturl = Chang_Phone;
        [mdict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"login"] forKey:@"userId"];
    }
    [self POSTurl:sturl parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        if ([responseObject[@"messageCode"] intValue] == 10000) {
            
            if (self.st) {
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"login"];
                [self.navigationController popToRootViewControllerAnimated:YES];
                [[Toast shareToast]makeText:@"修改成功" aDuration:2];
            }else{
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
        }
        [[Toast shareToast]makeText:[NSString stringWithFormat:@"%@",responseObject[@"message"]] aDuration:2];
            
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
    }];
}

@end
