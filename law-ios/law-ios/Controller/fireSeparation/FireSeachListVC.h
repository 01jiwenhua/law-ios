//
//  FireSeachListVC.h
//  law-ios
//
//  Created by 刘磊 on 2018/2/7.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "BaseViewController.h"

@interface FireModel : NSObject

@property (nonatomic, strong)NSDictionary * dict;
@property (nonatomic, strong)FireModel * model;
@end
@interface FireSeachListVC : BaseViewController

@property (nonatomic,copy)NSString * standard;
@end
