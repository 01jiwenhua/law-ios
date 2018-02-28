//
//  FireSeachVC.m
//  law-ios
//
//  Created by 刘磊 on 2018/2/7.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "FireSeachVC.h"
#import "ZWMSegmentController.h"
#import "FireSeachListVC.h"

@interface FireSeachVC ()
@property (nonatomic, strong) ZWMSegmentController *segmentVC;

@end

@implementation FireSeachVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray * titles = @[@""];
    FireSeachListVC * vc;
    NSString * standard = @"";
    if ([self.title isEqualToString:@"汽油加油加气站设计与施工规范"]) {
        titles = @[@"站址选择",@"站内平面布置"];
        standard = @"GB 50156-2012";
        
        NSMutableArray * mArr = [NSMutableArray new];
        for (NSString * str in titles) {
            vc = [NSClassFromString(@"FireSeachListVC") new];
            vc.title = str;
            vc.standard = standard;
            [mArr addObject:vc];
        }
        
        self.segmentVC = [[ZWMSegmentController alloc] initWithFrame:self.view.bounds titles:titles];
        self.segmentVC.segmentView.showSeparateLine = YES;
        self.segmentVC.segmentView.segmentTintColor = RGBColor(65,162, 240);
        
        self.segmentVC.viewControllers = mArr;
        if (self.segmentVC.viewControllers.count==1) {
            self.segmentVC.segmentView.style=ZWMSegmentStyleDefault;
        } else {
            self.segmentVC.segmentView.style=ZWMSegmentStyleFlush;
        }
        [self addSegmentController:self.segmentVC];
        [self.segmentVC  setSelectedAtIndex:0];
        
        return ;
    }
    
    if ([self.title isEqualToString:@"建筑设计防火规范"]) {
        standard = @"GB50016-2014";
    }
    
    if ([self.title isEqualToString:@"石油化工企业设计防火规范"]) {
        standard = @"GB50160-2008";
    }
    
    WS(ws);
    [SVProgressHUD showWithStatus:@"加载中..."];
    [self POSTurl:GET_TABS parameters:@{@"data":[self dictionaryToJson:@{@"standard":standard}]} success:^(id responseObject) {
        [SVProgressHUD dismiss];

        NSMutableArray * titles = [NSMutableArray new];
        NSArray * tabs = [self arrayWithJsonString:responseObject[@"data"][@"tabs"]];
        for (id obj in tabs) {
            [titles addObject:([obj[@"name"] isKindOfClass:[NSString class]] ?obj[@"name"] :@"") ];
        }
        titles = (titles.count ? titles : @[@""].mutableCopy);
        FireSeachListVC * vc;
        
        NSMutableArray * mArr = [NSMutableArray new];
        for (NSString * str in titles) {
            vc = [NSClassFromString(@"FireSeachListVC") new];
            vc.title = str;
            vc.standard = standard;
            [mArr addObject:vc];
        }
        
        ws.segmentVC = [[ZWMSegmentController alloc] initWithFrame:self.view.bounds titles:titles];
        ws.segmentVC.segmentView.showSeparateLine = YES;
        ws.segmentVC.segmentView.segmentTintColor = RGBColor(65,162, 240);
        
        ws.segmentVC.viewControllers = mArr;
        if (ws.segmentVC.viewControllers.count==1) {
            ws.segmentVC.segmentView.style=ZWMSegmentStyleDefault;
        } else {
            ws.segmentVC.segmentView.style=ZWMSegmentStyleFlush;
        }
        [ws addSegmentController:ws.segmentVC];
        [ws.segmentVC  setSelectedAtIndex:0];
        
    } failure:^(id responseObject) {
        [[Toast shareToast]makeText:@"服务繁忙" aDuration:1];
        [SVProgressHUD dismiss];
    }];
}


@end
