//
//  NSString+InOrderSubstring.m
//  Zhongche
//
//  Created by 中车_LL_iMac on 16/8/18.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "NSString+InOrderSubstring.h"

@implementation NSString (InOrderSubstring)
-(BOOL)isInOrderSubstringForSting:(NSString *)sting
{
    NSString * childStr;
    NSMutableString * parentSting = [NSMutableString stringWithString:sting];
    int location = -1;
    NSRange range;
    for (int i = 0; i < self.length; i ++)
    {
        childStr = [self substringWithRange:NSMakeRange(i, 1)];
        range = [parentSting rangeOfString:childStr];
        if (range.length == 0 || (location != -1 && range.location < location))
        {
            return NO;
        }
        [parentSting deleteCharactersInRange:range];
        location = (int)range.location;
    }
    return YES;
}
@end
