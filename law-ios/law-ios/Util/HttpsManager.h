//
//  HttpsManager.h
//  law-ios
//
//  Created by 刘磊 on 2018/1/27.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <AFNetworking/AFNetworking.h>

@interface HttpsManager : AFHTTPSessionManager
+( instancetype)shareManager;


- (void)POSTurl:(NSString *)urlString parameters:(id)paremeters success:(void (^)(id responseObject))success failure:(void (^)(id responseObject))failure;
- (void)GETurl:(NSString *)urlString parameters:(id)paremeters success:(void (^)(id responseObject))success failure:(void (^)(id responseObject))failure;
@end
