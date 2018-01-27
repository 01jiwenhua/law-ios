//
//  NSString+Analytics.m
//  EdujiaApp
//
//  Created by Adam on 15/11/12.
//  Copyright © 2015年 edujia. All rights reserved.
//

#import "NSString+Analytics.h"

@implementation NSString (Analytics)

- (NSString *)getViewControllerName:(UIViewController *)viewController {
    
    
    NSDictionary *analyticDict = @{
                                   @"HomeViewControllerIphone"          :@"主页",
                                   @"BatchGroupViewControllerIphone"    :@"相册",
                                   @"BatchAssetViewControllerIphone"    :@"相机胶卷",
                                   @"BatchPreviewViewControllerIphone"  :@"预览",
                                   @"WSMosaicViewController"            :@"马赛克",
                                   @"WSPaintViewController"             :@"画笔",
                                   @"EditBlendWatermarkViewIphone"      :@"水印编辑",
                                   @"EditOptionViewControllerIphone"    :@"编辑水印条目",
                                   @"SettingsViewControllerIphone"      :@"设置",
                                   @"WebViewControllerIphone"           :@"网页 - ",
                                   @"SetWatermarkLocationIphone"        :@"水印预览位置",
                                   @"WSCameraViewController"            :@"水印相机",
                                   @"WSPersonViewController"            :@"个人中心",
                                   @"WSMyWatermarkViewController"       :@"我的水印",
                                   @"WSTasksViewController"             :@"更多任务",
                                   @"WSAchieveCoinViewController"       :@"邀请好友",
                                   @"WSCoinStoreViewController"         :@"金币换推广",
                                   @"WSMakeScreenShotMenuViewController":@"截图-菜单",
                                   @"WSChatScreenViewController"        :@"截图-微信聊天",
                                   @"WSReceiveRedPacketViewController"  :@"截图-收红包",
                                   @"WSChangeViewController"            :@"截图-零钱",
                                   };
    
    
    
    NSString *name = [analyticDict objectForKey:self];
    if ([self isEqualToString:@"WebViewControllerIphone"]) {
        NSString *titleName = viewController.title;
        name = [name stringByAppendingString:titleName];
    }
    
    //    Class class = NSClassFromString(@"WSMakeScreenViewController");
    //    if (WSCheckTarget(viewController, class)) {
    //        NSString *titleName = viewController.title;
    //        name = [name stringByAppendingString:titleName];
    //    }
    
    return name;
}

+ (NSString *)getEventName:(MobEventType)type {
    
    switch (type) {
            //*****************************************************************
            // MARK: - 首页
            //*****************************************************************
        case home_camera:
            return @"home_camera";
            break;
        case home_banner_click:
            return @"home_banner_click";
            break;
        case home_puzzle:
            return @"home_puzzle";
            break;
        case home_screenshot:
            return @"home_screenshot";
            break;
        case home_syk:
            return @"home_syk";
            break;
        case home_watermark:
            return @"home_watermark";
            break;
            
            //*****************************************************************
            // MARK: - 截图
            //*****************************************************************
        case screenshot_chat:
            return @"screenshot_chat";
            break;
        case screenshot_hongbao:
            return @"screenshot_hongbao";
            break;
        case screenshot_lingqian:
            return @"screenshot_lingqian";
            break;
            
            
        case style_color_font:
            return @"style_color_font";
            break;
        case paint_color:
            return @"paint_color";
            break;
        case mosaic_template:
            return @"mosaic_template";
            break;
        case preview_sig_muti:
            return @"preview_sig_muti";
            break;
        case preview_img_count:
            return @"preview_img_count";
            break;
        case preview_colors_color:
            return @"preview_colors_color";
            break;
        case preview_upload:
            return @"preview_upload";
            break;
            
        case wm_temp_hot:
            return @"wm_temp_hot";
            break;
            
        default:
            break;
    }
    return nil;
}

@end
