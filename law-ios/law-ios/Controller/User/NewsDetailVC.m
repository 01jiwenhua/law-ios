//
//  NewsDetailVC.m
//  law-ios
//
//  Created by 李雪阳 on 2018/2/9.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "NewsDetailVC.h"

@interface NewsDetailVC ()

@end

@implementation NewsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.lbTitle.text = self.stTitle;
    self.lb1.text = self.st1;
    self.lb2.text = self.st2;
    self.lb3.text = self.st3;
    self.lb4.text = self.st4;
    self.tv.text = self.st5;
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
