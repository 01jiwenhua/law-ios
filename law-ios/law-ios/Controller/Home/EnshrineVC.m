//
//  EnshrineVC.m
//  law-ios
//
//  Created by 刘磊 on 2018/2/4.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "EnshrineVC.h"
#import "ZWMSegmentController.h"
#import "EnshrineListVC.h"

@interface EnshrineVC ()
@property (nonatomic, strong) ZWMSegmentController *segmentVC;


@end

@implementation EnshrineVC
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"收藏";
    self.btnLeft.hidden = YES;
}


-(void)bindAction {
    
}


-(void)getData {
    
    NSArray * arr  = @[@"标准规范",@"法律法规",@"政策文件",@"危险化学品"];
    NSArray * typeCode = @[@"bzgf",@"flfg",@"zcwj",@"wxhxp"];
    NSMutableArray * array = [NSMutableArray new];
    
    EnshrineListVC * listVC;
    for (id obj in typeCode) {
        
        listVC = [EnshrineListVC new];
        listVC.level = @"";
        listVC.typeCode = obj;
        [array addObject:listVC];
    }
    
    self.segmentVC = [[ZWMSegmentController alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 20, WIDTH_, HEIGHT_ - 64) titles:arr];
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
