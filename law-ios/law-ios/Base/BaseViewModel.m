//
//  BaseViewModel.m
//  Zhongche
//
//  Created by lxy on 16/7/11.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "BaseViewModel.h"
#import "Toast.h"
#import "AFHTTPSessionManager.h"
#import "RACSignal.h"
#import "SVProgressHUD.h"
#import "NSString+Extension.h"
#import <SDVersion/SDVersion.h>

@implementation NSMutableDictionary(ZCDictionary)

- (void)setNoNullObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if (anObject) {
        [self setObject:anObject forKey:aKey];
    }
    else
    {
    }
}


@end


typedef BOOL(^WSTestBlock) (NSURLResponse *response, id responseObject, NSError *error);

@interface BaseViewModel ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, copy  ) WSTestBlock          wsTestBlock;

@end

@implementation BaseViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initManagerWithBaseURL:@""];
        [self initParam];
    }
    return self;
}

- (void)initParam {
        self.wsTestBlock = ^BOOL(NSURLResponse *response, id responseObject, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if (httpResponse.statusCode >= 500) {
            return YES;
        }
        else {
            return NO;
        }
    };
}

- (void)initManagerWithBaseURL:(NSString *)URL {
    
    self.manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:URL]];
    self.manager.requestSerializer.timeoutInterval = 9;
    [self.manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"image/jpg", nil]];
}



- (RACSignal *)GETWithTimeSp:(NSString *)method Param:(NSDictionary *)param {
    NSMutableDictionary *mutiDict = [NSMutableDictionary dictionaryWithDictionary:param];
    [mutiDict setValue:[NSString timesp] forKey:@"timesp"];
    return [self GET:method Param:[mutiDict copy]];
}

- (RACSignal *)GET:(NSString *)method Param:(NSDictionary *)param {
    return [self.manager rac_GET:method parameters:param retries:0 interval:800 test:self.wsTestBlock];
}

/**
 *  Post请求
 *
 */
- (RACSignal *)POST:(NSString *)method Param:(NSDictionary *)param {
  
    return [self.manager rac_POST:method parameters:param retries:0 interval:800 test:self.wsTestBlock];
}

/**
 *  Post请求（传图片）
 *
 */
- (RACSignal *)POST:(NSString *)method
              Param:(NSDictionary *)param
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))formDataBlock{
    self.manager.requestSerializer.timeoutInterval = 800;
    return [self.manager rac_POST:method
                       parameters:param
        constructingBodyWithBlock:formDataBlock
                          retries:0
                         interval:800
                             test:self.wsTestBlock];
    
}

- (id)getResponseData:(RACTuple *)tuple {
    return [tuple first];
}


@end
