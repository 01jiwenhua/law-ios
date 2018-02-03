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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)bindView {
    self.btnNext.layer.borderWidth = 0.7;
    self.btnNext.layer.masksToBounds = YES;
    self.title = @"注册";
}

//获取验证码
- (IBAction)getCodeAction:(id)sender {
}

//下一步
- (IBAction)nextAction:(id)sender {
}



@end
