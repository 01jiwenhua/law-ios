//
//  conditionChooseVC.h
//  law-ios
//
//  Created by 李雪阳 on 2018/1/28.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "BaseViewController.h"

@protocol SelectedDelegate<NSObject>
-(void)select:(NSString *)st;
@end

@interface ConditionChooseVC : BaseViewController

@property (weak, nonatomic) id <SelectedDelegate> delegate;

@end