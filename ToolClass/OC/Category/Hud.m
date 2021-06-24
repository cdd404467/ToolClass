//
//  CddHud.m
//  SH
//
//  Created by i7colors on 2019/12/12.
//  Copyright © 2019 surhoo. All rights reserved.
//

#import "Hud.h"
#import <MBProgressHUD.h>


@implementation Hud

/*** 只显示菊花 ***/
+ (MBProgressHUD *)show:(UIView *)view {
    MBProgressHUD *hud = [self publicSetting:view];
    hud.margin = 30;
    return hud;
}


/*** 只显示文本 ***/
+ (MBProgressHUD *)showTextOnly:(NSString *)text view:(UIView *)view {
    MBProgressHUD *hud = [self publicSetting:view];
    hud.mode = MBProgressHUDModeText;
    hud.margin = 15;
    hud.label.text = text;
    [hud hideAnimated:YES afterDelay:Delay_Time];
    return hud;
}

/*** 菊花和文本 ***/
+ (MBProgressHUD *)showWithText:(NSString *)text view:(UIView *)view {
    MBProgressHUD *hud = [self publicSetting:view];
    hud.margin = 20;
    hud.label.text = text;
    return hud;
}

/*** 自定义图片 ***/
+ (MBProgressHUD *)showWithImage:(NSString *)imageName text:(NSString *)text view:(UIView *)view {
    MBProgressHUD *hud = [self publicSetting:view];
    hud.margin = 30;
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    return hud;
}

/*** 关闭hud ***/
+ (void)hideHUD:(UIView * _Nullable)view {
    if (view == nil)
        view = SystemCompat.getKeyWindow;
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+ (void)showSwitchText:(MBProgressHUD *)hud text:(NSString *)text {
    hud.mode = MBProgressHUDModeText;
    hud.margin = 15;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.label.text = text;
    [hud hideAnimated:YES afterDelay:Delay_Time];
}

//公共设置
+ (MBProgressHUD *)publicSetting:(UIView *)view {
    if (view == nil)
        view = SystemCompat.getKeyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled= NO;
    hud.bezelView.color = UIColor.blackColor;
    hud.contentColor = UIColor.whiteColor;
    hud.animationType = MBProgressHUDAnimationZoom;
    //不设置的话hud为半透明
//    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

@end
