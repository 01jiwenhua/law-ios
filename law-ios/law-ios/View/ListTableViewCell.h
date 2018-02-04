//
//  ListTableViewCell.h
//  law-ios
//
//  Created by 刘磊 on 2018/2/1.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface ListTableViewCell : BaseTableViewCell

@property (nonatomic,strong)UILabel * TitlrLab;
@property (nonatomic,strong)UILabel * mLab;
@property (nonatomic,strong)UILabel * timeNewLab;
@property (nonatomic,strong)UILabel * DLab;
@property (nonatomic,strong)UIView * line;
@end
