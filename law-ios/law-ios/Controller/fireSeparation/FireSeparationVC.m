//
//  FireSeparationVC.m
//  law-ios
//
//  Created by 刘磊 on 2018/2/7.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "FireSeparationVC.h"
#import "ZWMSegmentController.h"

@interface FireSeparationVC ()
@property (nonatomic, strong) ZWMSegmentController *segmentVC;

@end

@implementation FireSeparationVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"防火间距";
}

-(void)getData {
    
    self.segmentVC = [[ZWMSegmentController alloc] initWithFrame:self.view.bounds titles:@[@"标准查询"]];
    //@[@"标准查询",@"模糊查询"]
    self.segmentVC.segmentView.showSeparateLine = YES;
    self.segmentVC.segmentView.segmentTintColor = RGBColor(65,162, 240);
    self.segmentVC.viewControllers = @[[NSClassFromString(@"FireListVC") new],[BaseViewController new]];
    if (self.segmentVC.viewControllers.count==1) {
        self.segmentVC.segmentView.style=ZWMSegmentStyleDefault;
    } else {
        self.segmentVC.segmentView.style=ZWMSegmentStyleFlush;
    }
    [self addSegmentController:self.segmentVC];
    [self.segmentVC  setSelectedAtIndex:0];
}

@end
