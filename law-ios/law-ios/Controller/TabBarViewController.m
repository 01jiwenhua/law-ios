//
//  TabBarViewController.m
//  law-ios
//
//  Created by 刘磊 on 2018/1/31.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation TabBarViewController

-(instancetype)init {
    
    self = [super init];
    if (self)
    {
        NSArray * classStrings = @[@"HomeViewController",@"EnshrineVC",@"UserVC"];
        NSArray * titles = @[@"首页",@"收藏",@"我的"];
        NSArray * images = @[@"tab_home_normal",@"tab_collect_normal",@"tab_me_normal"];
        NSArray * selectedImages = @[@"tab_home_sel",@"tab_collect_sel",@"tab_me_sel"];
        UIViewController * vc;
        for (int i = 0; i < classStrings.count ; i ++)
        {
            vc = [NSClassFromString(classStrings[i]) new];
            vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:titles[i] image:[UIImage imageNamed:images[i]] selectedImage:[UIImage imageNamed:selectedImages[i]]];
            [self addChildViewController:vc];
        }
        self.delegate = self;
    }
    return self;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0) {
    if ([viewController isKindOfClass:NSClassFromString(@"UserVC")] && ![[NSUserDefaults standardUserDefaults] valueForKey:@"login"]) {
        [self.navigationController pushViewController:[NSClassFromString(@"LoginVC") new] animated:YES];
        return NO;
    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
