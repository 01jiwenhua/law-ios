//
//  NewsDetailVC.h
//  law-ios
//
//  Created by 李雪阳 on 2018/2/9.
//  Copyright © 2018年 app.demo. All rights reserved.
//

#import "BaseViewController.h"

@interface NewsDetailVC : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UITextView *tv;
@property (nonatomic, strong )NSString *stTitle;
@property (nonatomic, strong )NSString *st1;
@property (nonatomic, strong )NSString *st2;
@property (nonatomic, strong )NSString *st3;
@property (nonatomic, strong )NSString *st4;
@property (nonatomic, strong )NSString *st5;
@end
