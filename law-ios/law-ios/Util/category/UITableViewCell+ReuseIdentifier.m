//
//  UITableViewCell+ReuseIdentifier.m
//  SimpleTempView
//
//  Created by Adam on 15/12/21.
//  Copyright © 2015年 Adam. All rights reserved.
//

#import "UITableViewCell+ReuseIdentifier.h"

@implementation UITableViewCell (ReuseIdentifier)
+ (NSString *)reuseIdentifier
{
    return NSStringFromClass(self);
}

@end
