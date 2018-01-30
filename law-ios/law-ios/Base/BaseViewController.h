//
//  AppDelegate.h
//  Zhongche
//
//  Created by lxy on 16/7/8.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Toast.h"
#import "UIView+Frame.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "HttpsManager.h"
#import "YYModel.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIButton *btnRight;
@property (nonatomic, strong) UIButton *btnLeft;
   
- (void)bindView;
- (void)bindModel;
- (void)bindAction;
- (void)getData;
- (void)onBackAction;
- (void)onRightAction;

- (void)POSTurl:(NSString *)urlString parameters:(id)paremeters success:(void (^)(id responseObject))success failure:(void (^)(id responseObject))failure;
- (void)GETurl:(NSString *)urlString parameters:(id)paremeters success:(void (^)(id responseObject))success failure:(void (^)(id responseObject))failure;
- (NSString*)dictionaryToJson:(NSDictionary *)dic;
- (id)arrayWithJsonString:(NSString *)jsonString;
@end
