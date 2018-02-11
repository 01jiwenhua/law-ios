//
//  NSString+Extension.h
//  EdujiaApp
//
//  Created by Adam on 15/11/18.
//  Copyright © 2015年 edujia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Extension)
- (CGFloat)fontSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size minimumFontSize:(CGFloat)minimumFontSize;
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
+ (NSString *)timesp;
- (NSString *)append:(NSString *)str;
- (NSString *)replace:(NSString *)str withString:(NSString *)replaceStr;
- (NSString *)lastStr;
- (NSString *)removeLastStr;
- (BOOL)hasStr:(NSString *)str;

//*****************************************************************
// MARK: - 文件名处理
//*****************************************************************
- (NSString *)delExtension;

@end
