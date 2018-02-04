//
//  SEARCHLISTVC.h
//  law-ios
//
//  Created by 刘磊 on 2018/2/4.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "BaseViewController.h"

@interface SEARCHLISTVC : BaseViewController
@property (nonatomic, copy)NSString * typeCode;
@property (nonatomic, copy)NSString * level;

@property (nonatomic,copy)NSString * searchStr;
@property (nonatomic,assign)int page;
@end
