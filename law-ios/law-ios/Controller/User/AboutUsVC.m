//
//  AboutUsVC.m
//  law-ios
//
//  Created by 李雪阳 on 2018/2/9.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "AboutUsVC.h"
#import "YJVC.h"
#import "AXWebViewController.h"
#import "DynamicDetailsViewController.h"

@interface AboutUsVC ()

@end

@implementation AboutUsVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.title = @"关于我们";
}
- (IBAction)btn1:(id)sender {
    DynamicDetailsViewController *webVC = [DynamicDetailsViewController new];
//    AXWebViewController *webVC = [[AXWebViewController alloc] initWithAddress:@"http://60.210.40.196:25018/law-server/version.jsp"];
    webVC.urlStr = @"http://60.210.40.196:25018/law-server/version.jsp";
    webVC.title = @"版本说明";
    [self.navigationController pushViewController:webVC animated:YES];
}
- (IBAction)btn2:(id)sender {
    [self.navigationController pushViewController:[YJVC new] animated:YES];
}
- (IBAction)btn3:(id)sender {
    DynamicDetailsViewController *webVC = [DynamicDetailsViewController new];
    webVC.urlStr = @"http://60.210.40.196:25018/law-server/serviceitem.jsp";
//    AXWebViewController *webVC = [[AXWebViewController alloc] initWithAddress:@"http://60.210.40.196:25018/law-server/serviceitem.jsp"];
    webVC.title = @"服务协议";
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
