//
//  UIView+Extension.swift
//  full_lease_landlord
//
//  Created by apple on 2021/1/7.
//  Copyright © 2021 apple. All rights reserved.
//

import Foundation

extension UIView {
    public var origin: CGPoint {
        get { return frame.origin }
        set { frame.origin = newValue }
    }
    
    public var size: CGSize {
        get { return frame.size }
        set { frame.size = newValue }
    }
    
    public var left: CGFloat {
        get { return frame.origin.x }
        set { frame.origin = CGPoint(x: newValue, y: frame.origin.y) }
    }
    
    public var right: CGFloat {
        get { return frame.origin.x + frame.size.width }
        set { frame.origin = CGPoint(x: newValue - frame.size.width, y: frame.origin.y) }
    }
    
    public var top: CGFloat {
        get { return frame.origin.y }
        set { frame.origin = CGPoint(x: frame.origin.x, y: newValue) }
    }

    public var bottom: CGFloat {
        get { return frame.origin.y + frame.size.height }
        set { frame.origin = CGPoint(x: frame.origin.x, y: newValue - frame.size.height) }
    }
    
    public var width: CGFloat {
        get { return frame.size.width }
        set { frame.size = CGSize(width: newValue, height: frame.size.width) }
    }

    public var height: CGFloat {
        get { return frame.size.height }
        set { frame.size = CGSize(width: frame.size.height, height: newValue) }
    }
    
    public var centerX: CGFloat {
        get { return center.x }
        set { center = CGPoint(x: newValue, y: center.y) }
    }

    public var centerY: CGFloat {
        get { return center.y }
        set { center = CGPoint(x: center.x, y: newValue) }
    }
}

extension UIView {
    private struct AssociatedKey {
        static var identifier: String = "identifier"
        static var viewTypeId: String = "viewTypeId"
    }
    var viewStrId: String {
        get {
            return objc_getAssociatedObject(self, AssociatedKey.identifier) as? String ?? ""
        }
        
        set {
            objc_setAssociatedObject(self, AssociatedKey.identifier, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    //渐变色
    func setLayerColors(_ colors:[CGColor]) {
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = gradientLocations
        
        gradientLayer.frame = self.bounds
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        self.layer.addSublayer(gradientLayer)
    }
    
}
