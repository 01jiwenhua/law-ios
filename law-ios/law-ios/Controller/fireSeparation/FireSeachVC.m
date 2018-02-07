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
        titles = @[@"站址选择",@"站内平面布局"];
        standard = @"GB 50156-2012";
    }
    
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
}


@end
