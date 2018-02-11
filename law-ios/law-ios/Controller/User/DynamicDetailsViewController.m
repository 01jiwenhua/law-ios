//
//  DynamicDetailsViewController.m
//  LogisticsAssistant
//
//  Created by 中车_LL_iMac on 16/9/2.
//  Copyright © 2016年 com.chongche.cn. All rights reserved.
//

#import "DynamicDetailsViewController.h"
#import <WebKit/WebKit.h>

@interface DynamicDetailsViewController()

@property (nonatomic, strong) UIView * web;


@end

@implementation DynamicDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


-(void)bindView {
    self.web.frame = CGRectMake(0, 0, WIDTH_, HEIGHT_ - 64);
    [self.view addSubview:self.web];
}

//网页URL设置
-(void)setUrlStr:(NSString *)urlStr {
    _urlStr = [urlStr copy];
    NSURL* url = [NSURL URLWithString:_urlStr];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [self.web performSelector:@selector(loadRequest:) withObject:request];
    NSString *jsString = [[NSString alloc] initWithFormat:@"document.body.style.fontSize=16"];
    [(UIWebView *)self.web stringByEvaluatingJavaScriptFromString:jsString];
}

- (UIView *)web {
    if (!_web) {
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] <8.0)
//        {
            _web = [UIWebView new];
//        }
//        else
//        {
//            _web = [WKWebView new];
//        }
    }
    return _web;
}

@end
