//
//  UICollectionViewCell+ReuseIdentifier.m
//  EdujiaApp
//
//  Created by 侯耀东 on 15/11/6.
//  Copyright © 2015年 edujia. All rights reserved.
//

#import "UICollectionViewCell+ReuseIdentifier.h"

@implementation UICollectionViewCell (ReuseIdentifier)

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass(self);
}

@end
