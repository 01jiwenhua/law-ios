//
//  SearchTypeViewController.m
//  law-ios
//
//  Created by 刘磊 on 2018/1/28.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "SearchTypeViewController.h"
#import "ZWMSegmentController.h"
#import "ListViewController.h"

@interface SearchTypeViewController ()
@property (nonatomic, strong) ZWMSegmentController *segmentVC;

@end

@implementation SearchTypeViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray * arr = @[@"国家法律",@"行政法规",@"部门规章",@"地方法规"];
    NSMutableArray * array = [NSMutableArray new];
    ListViewController * listVC;
    for (id obj in arr) {
        listVC = [ListViewController new];
        listVC.level = obj;
        [array addObject:listVC];
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
