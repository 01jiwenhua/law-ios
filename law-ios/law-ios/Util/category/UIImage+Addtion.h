//
//  UIImage+Addtion.h
//  testMacais
//
//  Created by 侯耀东 on 15/11/7.
//  Copyright © 2015年 Adam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Addtion)



+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)scaleWithScale:(float)scale;
- (UIImage *)scaleToSize:(CGSize)size;
- (UIImage *)imageCompressForWidth:(CGFloat)defineWidth;
- (UIImage *)cutCenterWithSize:(CGSize)size;
- (UIImage *)maskWithImage:(const UIImage *)maskImage;
- (UIImage *)renderAtSize:(const CGSize)size;
- (UIImage *)tileToSize:(CGSize)size;
- (UIImage *)circleImage:(CGFloat)inset;

- (UIImage *)append:(UIImage *)image size:(CGSize)size;


/**
 * fix orientation of the image
 */
- (UIImage *)fixOrientation;

/**
 * 转换成马赛克,level代表一个点转为多少level*level的正方形
 */
- (UIImage *)transToMosaicImageWithBlockLevel:(NSUInteger)level;
- (UIImage *)blurImage; //新添加方法
- (UIImage *)imageWithTintColor:(UIColor *)tintColor scale:(NSInteger)scale;
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor scale:(NSInteger)scale;
- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode scale:(NSInteger)scale;

- (BOOL)hasAlpha;
- (UIImage *)wsRotatedImageMatchingOrientation:(UIImageOrientation)orientation;
- (UIImageOrientation)wsRotatedImageMatchingCameraViewWithOrientation:(UIDeviceOrientation)deviceOrientation;
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;


/**
 *  图片旋转
 *
 *  @param radians 旋转
 *
 *  @return <#return value description#>
 */
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;




@end
