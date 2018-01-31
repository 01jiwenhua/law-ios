//
//  SearchTypeViewController.m
//  law-ios
//
//  Created by 刘磊 on 2018/1/28.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "SearchTypeViewController.h"
#import "ZWMSegmentController.h"
#import "SearchViewController.h"

@interface SearchTypeViewController ()
@property (nonatomic, strong) ZWMSegmentController *segmentVC;

@end

@implementation SearchTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"查询";
    
    NSArray * arr = @[@"安全",@"安全标准",@"部门规章",@"地方法规",@"国家标准",@"安全",@"安全标准",@"部门规章",@"地方法规",@"国家标准"];
    NSMutableArray * array = [NSMutableArray new];
    for (id obj in arr) {
        [array addObject:[SearchViewController new]];
    }
    
    
    self.segmentVC = [[ZWMSegmentController alloc] initWithFrame:self.view.bounds titles:arr];
    self.segmentVC.segmentView.showSeparateLine = YES;
    self.segmentVC.segmentView.segmentTintColor = RGBColor(65,162, 240);
    self.segmentVC.viewControllers = [array copy];
    if (array.count==1) {
        self.segmentVC.segmentView.style=ZWMSegmentStyleDefault;
    } else {
        self.segmentVC.segmentView.style=ZWMSegmentStyleFlush;
    }
    [self addSegmentController:self.segmentVC];
    [self.segmentVC  setSelectedAtIndex:0];
}


@end
