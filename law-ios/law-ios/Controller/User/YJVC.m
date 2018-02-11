//
//  YJVC.m
//  law-ios
//
//  Created by 李雪阳 on 2018/2/9.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "YJVC.h"
#import "YMTextView.h"


@interface YJVC ()
@property (nonatomic, strong ) YMTextView *v ;

@end

@implementation YJVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)bindView {
    self.title = @"意见与反馈";
    _v = [YMTextView new];
    _v.frame = CGRectMake(10, 10, WIDTH_ - 20, 200);
    _v.placeholder = @"请留下您的宝贵意见或建议，我们将努力改进";
    [self.view addSubview:_v];
    self.btnRight.hidden = NO;
    [self.btnRight setTitle:@"提交" forState:UIControlStateNormal];
    [self.btnRight setTitleColor:BLUE forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

-(void)onRightAction{
    NSMutableDictionary * mdict = [NSMutableDictionary new];
    [mdict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"login"] forKey:@"userId"];
    [mdict setValue:_v.text forKey:@"content"];
    WS(ws);
    [self POSTurl:Submit_Message parameters:@{@"data":[self dictionaryToJson:mdict]} success:^(id responseObject) {
        [[Toast shareToast]makeText:@"提交成功" aDuration:1];
        [ws.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD dismiss];
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
