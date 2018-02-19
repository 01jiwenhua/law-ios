//
//  ListTableViewCell.m
//  law-ios
//
//  Created by 刘磊 on 2018/2/1.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

-(void)bindView {
    self.TitlrLab = [UILabel new];
    self.TitlrLab.frame = CGRectMake(20, 15, WIDTH_ - 40, 18);
    self.TitlrLab.font = [UIFont systemFontOfSize:18];
    self.TitlrLab.textColor = RGBColor(42, 42, 48);
    [self addSubview:self.TitlrLab];
    
    self.mLab = [UILabel new];
    self.mLab.frame = CGRectMake(20, 91, WIDTH_ - 130, 18);
    self.mLab.font = [UIFont systemFontOfSize:14];
    self.mLab.textColor = RGBColor(168, 168, 168);
    [self addSubview:self.mLab];
    
    self.timeNewLab = [UILabel new];
    self.timeNewLab.textAlignment = NSTextAlignmentRight;
    self.timeNewLab.frame = CGRectMake(self.mLab.right, 91, 90, 18);
    self.timeNewLab.font = [UIFont systemFontOfSize:14];
    self.timeNewLab.textColor = RGBColor(168, 168, 168);
    [self addSubview:self.timeNewLab];
    
    self.DLab = [UILabel new];
    self.DLab.frame = CGRectMake(20, 40, WIDTH_ - 40, 40);
    self.DLab.font = [UIFont systemFontOfSize:14];
    self.DLab.textColor = RGBColor(103, 103, 103);
    self.DLab.numberOfLines = 0;
    [self addSubview:self.DLab];
    
    self.line = [UIView new];
    self.line.frame = CGRectMake(0, 111, WIDTH_ , 0.5);
    self.line.backgroundColor = RGBColor(233, 233, 233);
    [self addSubview:self.line];
}
@end
