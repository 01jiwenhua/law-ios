//
//  NotificationVC.m
//  law-ios
//
//  Created by 李雪阳 on 2018/2/4.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "NotificationVC.h"

@interface NotificationVC ()

@property (weak, nonatomic) IBOutlet UISwitch *sw;

@end

@implementation NotificationVC

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.title = @"通知管理";
    self.sw.onTintColor = BLUE;
    
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
