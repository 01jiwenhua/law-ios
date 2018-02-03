//
//  LoginTableViewCell.m
//  law-ios
//
//  Created by 刘磊 on 2018/2/2.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "LoginTableViewCell.h"

@implementation LoginTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bindView {
    self.loginLab = [UILabel new];
    self.loginLab.frame = CGRectMake(20, 38, 150, 22);
    self.loginLab.text = @"点击登录";
    self.loginLab.font = [UIFont systemFontOfSize:22];
    self.loginLab.textColor = RGBColor(71, 71, 71);
    [self addSubview:self.loginLab];
    
    self.loginLab = [UILabel new];
    self.loginLab.frame = CGRectMake(20, 70, 150, 14);
    self.loginLab.text = @"立即登录体验完整功能";
    self.loginLab.font = [UIFont systemFontOfSize:14];
    self.loginLab.textColor = RGBColor(71, 71, 71);
    [self addSubview:self.loginLab];
}
@end
