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

@property (nonatomic, strong)UILabel * titleLab;
@end

@implementation EnshrineVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"收藏";
    self.btnLeft.hidden = YES;
    
    UIView * vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_, self.navigationController.navigationBar.height + 20)];
    vi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vi];
    
    self.titleLab.frame = CGRectMake(0, vi.bottom - 44, WIDTH_ , 36);
    [vi addSubview:self.titleLab];
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


-(UILabel *)titleLab {
    if (!_titleLab) {
        UILabel * lab = [UILabel new];
        lab.font = [UIFont systemFontOfSize:18.f];
        lab.text = @"收藏";
        lab.textColor = RGBColor(73, 73, 73);
        lab.textAlignment = NSTextAlignmentCenter;
        lab.frame = CGRectMake(50, 0, WIDTH_ - 100, 40);
        
        _titleLab = lab ;
    }
    return _titleLab;
}
@end
