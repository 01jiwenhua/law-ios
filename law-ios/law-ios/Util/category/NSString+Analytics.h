//
//  NSString+Analytics.h
//  EdujiaApp
//
//  Created by Adam on 15/11/12.
//  Copyright © 2015年 edujia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    home_camera,            //首页-拍照按钮
    home_puzzle,            //首页-拼图
    home_screenshot,        //首页-截图
    home_watermark,         //首页-批量水印
    home_syk,               //首页-水印库
    
    screenshot_chat,        //截图聊天
    screenshot_hongbao,     //截图红包
    screenshot_lingqian,    //截图零钱
    screenshot_zhuanzhang,  //截图转账
    
    style_color_font,       //样式（颜色_字体）
    paint_color,            //画笔颜色选择
    mosaic_template,        //马赛克模板
    preview_img_count,      //预览-图片数量
    preview_sig_muti,       //预览-单张_批量按钮
    preview_upload,         //预览-上传
    preview_colors_color,   //预览页面颜色选择
    home_banner_click,      //首页banner点击
    wm_temp_hot,            //水印使用统计
    
} MobEventType;

@interface NSString (Analytics)

/**
 *  @author Adam, 15-11-12 15:11:25
 *
 *  获取对应Controller统计名称
 *
 *  @param viewController
 *
 *  @return 名称
 */
- (NSString *)getViewControllerName:(UIViewController *)viewController;

/**
 *  @author Adam, 15-11-12 15:11:41
 *
 *  获取统计事件名称
 *
 *  @param type 事件
 *
 *  @return 
 */
+ (NSString *)getEventName:(MobEventType)type;

@end
