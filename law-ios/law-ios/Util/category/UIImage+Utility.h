//
//  UIImage+Utility.h
//  EdujiaApp
//
//  Created by kinidchen on 16/1/19.
//  Copyright © 2016年 edujia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utility)
+ (UIImage*)fastImageWithData:(NSData*)data;
+ (UIImage*)fastImageWithContentsOfFile:(NSString*)path;

- (UIImage*)deepCopy;
- (UIImage*)grayScaleImage;

- (UIImage*)resize:(CGSize)size;
- (UIImage*)aspectFit:(CGSize)size;
- (UIImage*)aspectFill:(CGSize)size;
- (UIImage*)aspectFill:(CGSize)size offset:(CGFloat)offset;

- (UIImage*)crop:(CGRect)rect;
- (UIImage*)maskedImage:(UIImage*)maskImage;

- (UIImage*)gaussBlur:(CGFloat)blurLevel;       //  {blurLevel | 0 ≤ t ≤ 1}
@end
