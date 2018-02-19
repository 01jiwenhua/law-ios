//
//  NSString+Password.m
//  Zhongche
//
//  Created by 刘磊 on 16/8/1.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "NSString+Password.h"

@implementation NSString (Password)
- (StringType)theComplexity
{
    StringType type = nullString;
    
    UniChar a;
    for(int i =0; i < [self length]; i++)
    {
        a = [self characterAtIndex:i];
        if ((a >= 'a' && a <= 'z') || (a >= 'A' && a <= 'Z'))
        {
            if ((type & letter) != letter) {
                type |= letter;
            }
        }
        else if (a >= '0' && a <= '9')
        {
            if ((type & number) != number) {
                type |= number;
            }
        }
        else
        {
            if ((type & specialCharacters) != specialCharacters) {
                type |= specialCharacters;
            }
        }
    }
    return type;
}
@end
