//
//  NSString+Password.h
//  Zhongche
//
//  Created by 刘磊 on 16/8/1.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    letter = 1 << 0,
    number = 1 << 1,
    specialCharacters = 1 << 2,
    nullString = 0,
}StringType;

@interface NSString (Password)
- (StringType)theComplexity;
@end
