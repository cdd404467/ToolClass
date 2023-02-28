//
//  PublicPara.swift
//  full_lease_landlord
//
//  Created by apple on 2021/1/27.
//  Copyright © 2021 apple. All rights reserved.
//

import Foundation


//被OC和swift同时调用的用类方法，只swift调用的用属性
public class UIFit: NSObject {
    
    static func screen_bounds() -> CGRect {
        UIScreen.main.bounds
    }
    
    static func screen_width() -> CGFloat {
        UIScreen.main.bounds.width
    }
    
    static func screen_height() -> CGFloat {
        UIScreen.main.bounds.height
    }
    
    static func isIphoneX() -> Bool {
        max(screen_width(), screen_height()) > 736 ? true : false
    }
    
    //上方安全区域
    static func topSaveArea_height() -> CGFloat {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else {return 0}
            guard let window = windowScene.windows.first else {return 0}
            return window.safeAreaInsets.top
        }
        return 0
    }
    
    //下方安全区域
    static func bottomSaveArea_height() -> CGFloat {
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else {return 0}
            guard let window = windowScene.windows.first else {return 0}
            return window.safeAreaInsets.bottom
        }
        return 0
    }
    
    static func stateBar_height() -> CGFloat {
        var statusBarHeight: CGFloat = 0.0
        
            
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else {return 0}
            guard let statusBarManager = windowScene.statusBarManager else {return 0}
//            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
//            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            statusBarHeight = statusBarManager.statusBarFrame.height
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
    
    static func navBar_height() -> CGFloat {
        return 44.0
    }
    
    static func tabBar_height() -> CGFloat {
        
        isIphoneX() ? bottomSaveArea_height() + 49.0 : 49.0
    }
    
    static func nav_height() -> CGFloat {
        stateBar_height() + navBar_height()
//        isIphoneX() ? 88.0 : 64.0
    }
    
    static func top_height_dif() -> CGFloat {
        isIphoneX() ? topSaveArea_height() : 0
    }
    
    static func bottom_height_dif() -> CGFloat {
        isIphoneX() ? bottomSaveArea_height() : 0
    }
    
    static func kfit_w(_ variate: CGFloat) -> CGFloat {
        return variate * screen_width() / 375
    }
    
    static func kfit_h(_ variate: CGFloat) -> CGFloat {
        return variate * screen_height() / 667
    }
    
    @objc static func mainColor() -> UIColor {
        HexColor("#FF6582", 1)
    }
    
    @objc static func tempBgColor() -> UIColor {
        RGBA(0, 0, 0, 0.03)
    }
}

