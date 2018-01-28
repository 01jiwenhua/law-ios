//
//  AppDelegate.m
//  law-ios
//
//  Created by 李雪阳 on 2018/1/26.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "GudePageVi.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //初始化图片适配后缀
    _window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UINavigationController * navi =[[UINavigationController alloc] initWithRootViewController:[HomeViewController new]];
    
    //设置导航条背景图片
    [navi.navigationBar setBackgroundImage:[UIImage getImageWithColor:RGBColor(65,162, 240) andSize:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
    
    //设置导航条字体颜色
    [navi.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.window.rootViewController = navi;
    [_window makeKeyAndVisible];
    //改变状态栏颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    self.window.rootViewController = navi;
    [_window makeKeyAndVisible];
    
    
    //引导页
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstOpenGudePageVi1"]) {
        
        NSUserDefaults * appdict = [NSUserDefaults standardUserDefaults];
        [appdict setObject:@YES forKey:@"isFirstOpenGudePageVi"];
        GudePageVi * vi = [GudePageVi new];
        vi.frame = [UIScreen mainScreen].bounds;
        [self.window addSubview:vi];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
