//
//  BaseViewModel.h
//  Zhongche
//
//  Created by lxy on 16/7/11.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager+RACRetrySupport.h"
#import "Toast.h"
#import "SVProgressHUD.h"

typedef void(^WSNetErrorBlack)(NSError* error);

@interface BaseViewModel : NSObject

@property (nonatomic, copy) WSNetErrorBlack errorBlock;
@property (nonatomic, strong) NSMutableDictionary  *dicHead;
@property (nonatomic, strong) NSMutableDictionary  *dicRequest;

- (RACSignal *)POST:(NSString *)method Param:(NSDictionary *)param;
/**
 *  Post请求（传图片）
 *
 */
- (RACSignal *)POST:(NSString *)method
              Param:(NSDictionary *)param
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))formDataBlock;

@end
