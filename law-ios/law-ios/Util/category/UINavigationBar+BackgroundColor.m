//
//  UINavigationBar+BackgroundColor.m
//  EdujiaApp
//
//  Created by 侯耀东 on 16/3/13.
//  Copyright © 2016年 edujia. All rights reserved.
//

#import "UINavigationBar+BackgroundColor.h"
#import <objc/runtime.h>

@implementation UINavigationBar (BackgroundColor)
static char overlayKey;

- (UIImageView *)overlay {
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIImageView *)overlay {
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)ws_setBackgroundColor:(UIColor *)backgroundColor {
    if (!self.overlay) {
        
        self.overlay = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"braceletNavBarDefaultShadowBG"]];
        self.overlay.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64);
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)ws_hideBackground:(BOOL)isHide {
    [self.overlay setHidden:isHide];
}

@end
