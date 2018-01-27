//
//  UIImage+getImage.h
//  绘制单色图
//
//  Created by 中车_LL_iMac on 16/8/31.
//  Copyright © 2016年 com.chongche.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (getImage)
//生成单色图
+(UIImage*) getImageWithColor:(UIColor*)color andSize:(CGSize)size;
//圆角图
-(id)createRadius:(NSInteger)r;
@end
