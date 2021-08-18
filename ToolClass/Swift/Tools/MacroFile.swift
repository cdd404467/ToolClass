//
//  MacroFile.swift
//  full_lease_landlord
//
//  Created by apple on 2020/9/28.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit



/*这是一个宏文件*/

var SCREEN_BOUNDS = UIFit.screen_bounds()
var SCREEN_WIDTH = UIFit.screen_width()
var SCREEN_HEIGHT = UIFit.screen_height()
var isIphoneX: Bool = UIFit.isIphoneX()
var STATEBAR_HEIGHT: CGFloat = UIFit.stateBar_height()
var TABBAR_HEIGHT: CGFloat = UIFit.tabBar_height()
var NAV_HEIGHT: CGFloat = UIFit.nav_height()
var Top_Height_Dif: CGFloat = UIFit.top_height_dif()
var Bottom_Height_Dif: CGFloat = UIFit.bottom_height_dif()

var ContactPhone: String {
    if let phone = UserDefaults.standard.object(forKey: "contactPhone") {
        return phone as! String
    }
    return ""
}

func KFit_W(_ variate: CGFloat) -> CGFloat {
    return UIFit.kfit_w(variate)
}

func KFit_H(_ variate: CGFloat) -> CGFloat {
    return UIFit.kfit_h(variate)
}

func KFont(_ value: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: UIFit.kfit_w(value))
}

func RGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
    return UIColor(r: r, g: g, b: b, a: a)
}

func HexColor(_ colorString: String, _ alpha: CGFloat = 1) -> UIColor {
    return UIColor.hex(hexString: colorString, alpha: alpha)
}


