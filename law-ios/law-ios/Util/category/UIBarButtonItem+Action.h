//
//  UIBarButtonItem+Action.h
//  EdujiaApp
//
//  Created by 侯耀东 on 16/3/15.
//  Copyright © 2016年 edujia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BarButtonActionBlock)();

@interface UIBarButtonItem (Action)


+ (id)fixItemSpace:(CGFloat)space;

- (id)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style actionBlick:(BarButtonActionBlock)actionBlock;

- (id)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style actionBlick:(BarButtonActionBlock)actionBlock;

- (id)initWithBackTitle:(NSString *)title target:(id)target action:(SEL)action;

/// A block that is run when the UIBarButtonItem is tapped.
//@property (nonatomic, copy) dispatch_block_t actionBlock;
- (void)setActionBlock:(BarButtonActionBlock)actionBlock;

@end
