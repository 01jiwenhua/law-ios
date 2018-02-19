//
//  HttpsManager.m
//  law-ios
//
//  Created by 刘磊 on 2018/1/27.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "HttpsManager.h"

static HttpsManager *_instance;

@implementation HttpsManager
#pragma mark - 创建请求者

+( instancetype)shareManager {
    if (!_instance) {
        static dispatch_once_t onceToken;
        __weak typeof(self) weakSelf = self;
        dispatch_once(&onceToken, ^{
            _instance = [[weakSelf alloc]init];
            _instance.responseSerializer = [AFJSONResponseSerializer serializer];
            
            _instance.responseSerializer.acceptableContentTypes = [_instance.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            [_instance.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/x-javascript"];
            _instance.responseSerializer = [AFJSONResponseSerializer serializer];
            _instance.requestSerializer.timeoutInterval = 10;
            
        });
    };
    return _instance;
    
}

- (void)POSTurl:(NSString *)urlString parameters:(id)paremeters success:(void (^)(id responseObject))success failure:(void (^)(id responseObject))failure{
    [_instance POST:urlString parameters:paremeters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
- (void)GETurl:(NSString *)urlString parameters:(id)paremeters success:(void (^)(id responseObject))success failure:(void (^)(id responseObject))failure{
    
    [_instance GET:urlString parameters:paremeters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);

    }];
}
@end
