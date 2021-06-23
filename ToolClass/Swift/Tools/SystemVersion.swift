//
//  SystemVersion.swift
//  ToolClass
//
//  Created by caidongdong on 2021/6/21.
//

import Foundation

public class SystemCompat: NSObject {
    //获取keywindow
    @objc class func getKeyWindow() -> (UIWindow) {
        var kWindow: UIWindow? = nil
        if #available(iOS 13, *) {
            for windowScene: UIWindowScene in UIApplication.shared.connectedScenes as! Set<UIWindowScene> {
                if windowScene.activationState == .foregroundActive {
                    for window in windowScene.windows {
                        if window.isKeyWindow {
                            kWindow = window
                            break
                        }
                    }
                }
                if kWindow != nil {
                    break
                }
            }
        }
        else {
            kWindow = UIApplication.shared.keyWindow
        }
        return kWindow!
    }
    
    
        
}
