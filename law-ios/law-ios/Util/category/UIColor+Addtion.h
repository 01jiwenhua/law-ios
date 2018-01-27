//
//  UIColor+Addtion.h
//  EdujiaApp
//
//  Created by Adam on 15/12/7.
//  Copyright © 2015年 edujia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Addtion)

@property (nonatomic, readonly) CGFloat red;
@property (nonatomic, readonly) CGFloat green;
@property (nonatomic, readonly) CGFloat blue;
@property (nonatomic, readonly) CGFloat alpha;

+ (void)registerColor:(UIColor *)color forName:(NSString *)name;

+ (instancetype)colorWithString:(NSString *)string;
+ (instancetype)colorWithRGBValue:(uint32_t)rgb;
+ (instancetype)colorWithRGBAValue:(uint32_t)rgba;
- (instancetype)initWithString:(NSString *)string;
- (instancetype)initWithRGBValue:(uint32_t)rgb;
- (instancetype)initWithRGBAValue:(uint32_t)rgba;

- (uint32_t)RGBValue;
- (uint32_t)RGBAValue;
- (NSString *)stringValue;

- (BOOL)isMonochromeOrRGB;
- (BOOL)isEquivalent:(id)object;
- (BOOL)isEquivalentToColor:(UIColor *)color;

- (instancetype)colorWithBrightness:(CGFloat)brightness;
- (instancetype)colorBlendedWithColor:(UIColor *)color factor:(CGFloat)factor;

+ (NSString *)stringWithColor:(UIColor *)color;
+ (UIColor *)colorWithHexString: (NSString *)color;

@end
