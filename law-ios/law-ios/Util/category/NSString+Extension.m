//
//  NSString+Extension.m
//  EdujiaApp
//
//  Created by Adam on 15/11/18.
//  Copyright © 2015年 edujia. All rights reserved.
//

#import "NSString+Extension.h"

#define WSMAX_SIZE CGSizeMake(size.width,FLT_MAX)

@implementation NSString (Extension)

- (CGFloat)fontSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size minimumFontSize:(CGFloat)minimumFontSize {
    CGFloat fontSize = [font pointSize];
    CGFloat height = [self sizeWithFont:font maxSize:WSMAX_SIZE].height;
    UIFont *newFont = font;
    
    //Reduce font size while too large, break if no height (empty string)
    while (height > size.height && height != 0 && fontSize > minimumFontSize) {
        fontSize--;
        newFont = [UIFont fontWithName:font.fontName size:fontSize];
        height = [self sizeWithFont:newFont maxSize:WSMAX_SIZE].height;
    };
    
    // Loop through words in string and resize to fit
    for (NSString *word in [self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]) {
        CGFloat width = [word sizeWithFont:newFont maxSize:WSMAX_SIZE].width;
        while (width > size.width && width != 0 && fontSize > minimumFontSize) {
            fontSize--;
            newFont = [UIFont fontWithName:font.fontName size:fontSize];
            width = [word sizeWithFont:newFont maxSize:WSMAX_SIZE].width;
        }
    }
    return fontSize;
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    if (font == nil) {
        font = [UIFont systemFontOfSize:20.f];
    }
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:attrs
                              context:nil].size;
}

+ (NSString *)timesp {
    return @([[NSDate date] timeIntervalSince1970]).stringValue;
}

- (NSString *)append:(NSString *)str {
    if (!str) {
        return self;
    }
    return [self stringByAppendingString:str];
}

- (NSString *)replace:(NSString *)str withString:(NSString *)replaceStr {
    return [self stringByReplacingOccurrencesOfString:str withString:replaceStr];
}

- (NSString *)lastStr {
    if (self.length <= 0) return nil;
    return [self substringFromIndex:self.length-1];
}

- (NSString *)removeLastStr {
    return [self substringToIndex:([self length]-1)];
}

- (NSString *)delExtension {
    return [self stringByDeletingPathExtension];
}

- (BOOL)hasStr:(NSString *)str {
    return [self rangeOfString:str].length > 0;
}

@end
