//
//  ListTableViewCell.m
//  law-ios
//
//  Created by 刘磊 on 2018/2/1.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

-(instancetype)init {
    if (self = [super init]) {
        
        self.TitlrLab = [UILabel new];
        self.TitlrLab.frame = CGRectMake(20, 15, WIDTH_ - 40, 18);
        self.TitlrLab.font = [UIFont systemFontOfSize:18];
        self.TitlrLab.textColor = RGBColor(42, 42, 48);
        [self addSubview:self.TitlrLab];
        
        self.timeLab = [UILabel new];
        self.timeLab.frame = CGRectMake(20, 42, WIDTH_ - 40, 18);
        self.timeLab.font = [UIFont systemFontOfSize:14];
        self.timeLab.textColor = RGBColor(168, 168, 168);
        [self addSubview:self.timeLab];
        
        self.DLab = [UILabel new];
        self.DLab.frame = CGRectMake(20, 60, WIDTH_ - 40, 40);
        self.DLab.font = [UIFont systemFontOfSize:18];
        self.DLab.textColor = RGBColor(233, 236, 72);
        self.DLab.numberOfLines = 0;
        [self addSubview:self.DLab];
        
        self.line = [UIView new];
        self.line.frame = CGRectMake(20, 111, WIDTH_ - 40, .5);
        self.line.backgroundColor = RGBColor(233, 236, 72);
        [self addSubview:self.line];
    }
    return self;
}
@end
