//
//  CddHud.h
//  SH
//
//  Created by i7colors on 2019/12/12.
//  Copyright © 2019 surhoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN
#define Delay_Time 1.5f
@interface Hud : NSObject
+ (MBProgressHUD *)show:(nullable UIView *)view;
+ (MBProgressHUD *)showTextOnly:(NSString *)text view:(nullable UIView *)view;
+ (MBProgressHUD *)showWithText:(NSString *)text view:(nullable UIView *)view;
+ (MBProgressHUD *)showWithImage:(NSString *)imageName text:(NSString *)text view:(nullable UIView *)view;
+ (void)showSwitchText:(MBProgressHUD *)hud text:(NSString *)text;
+ (void)hideHUD:(UIView * _Nullable)view;
@end

NS_ASSUME_NONNULL_END
