//
//  CommonTool.swift
//  full_lease_landlord
//
//  Created by apple on 2021/2/19.
//  Copyright © 2021 apple. All rights reserved.
//

import Foundation

class Help: NSObject {
    //获取当前window 显示的控制器
   @objc class func currentVC() -> UIViewController? {
    var window = SystemCompat.getKeyWindow()
    if window.windowLevel != UIWindow.Level.normal{
          let windows = UIApplication.shared.windows
          for  windowTemp in windows{
            if windowTemp.windowLevel == UIWindow.Level.normal{
               window = windowTemp
               break
             }
           }
         }
    let vc = window.rootViewController
        return currentViewController(vc)
    }
    
    private class func currentViewController(_ vc :UIViewController?) -> UIViewController? {
       if vc == nil {
          return nil
       }
       if let presentVC = vc?.presentedViewController {
          return currentViewController(presentVC)
       }
       else if let tabVC = vc as? UITabBarController {
          if let selectVC = tabVC.selectedViewController {
              return currentViewController(selectVC)
           }
           return nil
        }
        else if let naiVC = vc as? UINavigationController {
           return currentViewController(naiVC.visibleViewController)
        }
        else {
           return vc
        }
     }
    
    //判断模拟器
    @objc class func isSimuLator() -> Bool {
        if TARGET_IPHONE_SIMULATOR == 1 && TARGET_OS_IPHONE == 1 {
            return true
        } else {
            return false
        }
    }
    
    //判断是否debug
    @objc class func isDebug() -> Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    //数据是否有效
    @objc class func isRightData(_ object: Any) -> Bool {
        if object is String {
            let str: String = object as! String
            if str == "null" || str == "<null>" || str == "(null)" {
                return false
            }
            return true
        } else {
            if object is NSNull {
                return false
            }
            return true
        }
    }
}
