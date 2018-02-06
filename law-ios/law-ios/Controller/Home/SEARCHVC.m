//
//  SEARCHVC.m
//  law-ios
//
//  Created by 刘磊 on 2018/2/4.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "SEARCHVC.h"
#import "ZWMSegmentController.h"
#import "SEARCHLISTVC.h"

@interface SEARCHVC ()<UISearchBarDelegate>
@property (nonatomic, strong) ZWMSegmentController *segmentVC;

@property (nonatomic, strong)UISearchBar * search;

@end

@implementation SEARCHVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar addSubview:self.search];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.search.frame = CGRectMake(40, 5, WIDTH_ - 80, 36);
    [self.view addSubview:self.search];
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.search removeFromSuperview];
}

-(void)bindAction {
    
}


-(void)getData {
    
    NSArray * arr  = @[@"综合",@"法律法规",@"标准规范",@"政策文件",@"危险化学品",@"防火间距"];
    NSArray * typeCode = @[@"",@"flfg",@"bzgf",@"zcwj",@"wxhxp",@"fhjj"];
    NSMutableArray * array = [NSMutableArray new];

    SEARCHLISTVC * listVC;
    for (id obj in typeCode) {
        
        listVC = [SEARCHLISTVC new];
        listVC.level = @"";
        listVC.typeCode = obj;
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
    WS(ws);
    [self.segmentVC selectedAtIndex:^(NSUInteger index, UIButton * _Nonnull button, UIViewController * _Nonnull viewController) {
        SEARCHLISTVC * vc = (SEARCHLISTVC *)viewController;
        vc.searchStr = ws.search.text;
        vc.page = 0;
        [vc getData];
    }];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    SEARCHLISTVC * vc = (SEARCHLISTVC *)self.segmentVC.viewControllers[self.segmentVC.index];
    vc.searchStr = searchBar.text;
    vc.page = 0;
    [vc getData];
}

- (UISearchBar *)search {
    if (!_search) {
        _search = [UISearchBar new];
        [_search setBackgroundImage:[UIImage getImageWithColor:[UIColor clearColor] andSize:CGSizeMake(WIDTH_ - 72, 36)]];
        [_search setSearchFieldBackgroundImage:[[UIImage getImageWithColor:RGBColor(238, 238, 238) andSize:CGSizeMake(WIDTH_ - 72, 36)] createRadius:8] forState:UIControlStateNormal];
        _search.placeholder = @"搜索";
        _search.delegate = self;
        //一下代码为修改placeholder字体的颜色和大小
        UITextField * searchField = [_search valueForKey:@"_searchField"];
        [searchField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    }
    return _search;
}
@end
