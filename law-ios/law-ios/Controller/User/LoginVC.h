//
//  LoginVC.h
//  law-ios
//
//  Created by xueyang.li on 2018/2/1.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfCode;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnRegist;
@property (weak, nonatomic) IBOutlet UIButton *findPhone;

@end
