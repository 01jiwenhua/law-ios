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
    [_btnRight setFrame:CGRectMake(0, 0, 44, 30)];
    [_btnRight addTarget:self action:@selector(onRightAction) forControlEvents:UIControlEventTouchUpInside];
    _btnRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _btnRight.titleLabel.textAlignment = NSTextAlignmentRight;
    _btnRight.titleLabel.font = [UIFont systemFontOfSize:15];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:_btnRight];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.btnRight.hidden = YES;
    
    self.btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnLeft setFrame:CGRectMake(0, 0, 44, 30)];
    [_btnLeft addTarget:self action:@selector(onBackAction) forControlEvents:UIControlEventTouchUpInside];
    _btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    [_btnLeft setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
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
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [mgr POST:urlString parameters:paremeters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)GETurl:(NSString *)urlString parameters:(id)paremeters success:(void (^)(id responseObject))success failure:(void (^)(id responseObject))failure {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [mgr GET:urlString parameters:paremeters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];

}

//字典转换为字符串
- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (id)arrayWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id array = [NSJSONSerialization JSONObjectWithData:jsonData
                                             options:NSJSONReadingMutableContainers
                                               error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return array;
}
@end
