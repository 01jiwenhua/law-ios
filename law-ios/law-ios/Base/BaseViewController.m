//
//  AppDelegate.h
//  Zhongche
//
//  Created by lxy on 16/7/8.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"

@interface BaseViewController()

@end

@implementation BaseViewController

- (id)init {
    self = [super init];
    if (self) {
        [self initParameters];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self navigationSet];
    [self bindModel];
    [self bindView];
    [self bindAction];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)initParameters {

}


/**
 *  导航按钮设置
 */
- (void)navigationSet{
    
    self.btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnRight setFrame:CGRectMake(0, 0, 26, 20)];
    [_btnRight addTarget:self action:@selector(onRightAction) forControlEvents:UIControlEventTouchUpInside];

    _btnRight.titleLabel.textAlignment = NSTextAlignmentRight;
    _btnRight.titleLabel.font = [UIFont systemFontOfSize:15];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:_btnRight];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.btnRight.hidden = YES;
    
    self.btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnLeft setFrame:CGRectMake(0, 0, 26, 20)];
    [_btnLeft addTarget:self action:@selector(onBackAction) forControlEvents:UIControlEventTouchUpInside];

    [_btnLeft setImage:[UIImage imageNamed:@"fnahui"] forState:UIControlStateNormal];
    _btnLeft.highlighted = NO;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:_btnLeft];
    self.navigationItem.leftBarButtonItem = backItem;
}

/**
 *  加载视图
 */
- (void)bindView {
}

/**
 *  加载模型
 */
- (void)bindModel {
}

/**
 *  加载方法
 */
- (void)bindAction {
}

-(void)getData {
    
}
- (void)loadViews {
   
}

//*****************************************************************
// MARK: - actions
//*****************************************************************

/**
 *  导航控制器上角按钮方法
 */
- (void)onBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onRightAction
{

}

- (void)POSTurl:(NSString *)urlString parameters:(id)paremeters success:(void (^)(id responseObject))success failure:(void (^)(id responseObject))failure{
    [[HttpsManager shareManager] POSTurl:urlString parameters:paremeters success:success failure:failure];
}
- (void)GETurl:(NSString *)urlString parameters:(id)paremeters success:(void (^)(id responseObject))success failure:(void (^)(id responseObject))failure {
    [[HttpsManager shareManager] GETurl:urlString parameters:paremeters success:success failure:failure];

}
@end
