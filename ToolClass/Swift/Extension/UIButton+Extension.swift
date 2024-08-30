//
//  UIButton+Extension.swift
//  ToolClass
//
//  Created by caidongdong on 2021/6/24.
//

import Foundation

public extension UIButton {
    
    @objc enum ButtonImageEdgeInsetsStyle: Int {
        case top, left, right, bottom
    }
    
    @objc func imagePosition(at style: ButtonImageEdgeInsetsStyle, space: CGFloat) {
        imagePosition(at: style, space: space, isAutoWidth: false , maxWidth: -1.0)
    }
    
    @objc func imagePosition(at style: ButtonImageEdgeInsetsStyle, space: CGFloat, isAutoWidth: Bool = false) {
        imagePosition(at: style, space: space, isAutoWidth: isAutoWidth , maxWidth: -1.0)
    }
    
    @objc func imagePosition(at style: ButtonImageEdgeInsetsStyle, space: CGFloat, maxWidth: CGFloat = -1.0) {
        imagePosition(at: style, space: space, isAutoWidth: false , maxWidth: maxWidth)
    }
    
    @objc func imagePosition(at style: ButtonImageEdgeInsetsStyle, space: CGFloat, isAutoWidth: Bool = false, maxWidth: CGFloat = -1.0) {
        guard let imageV = imageView else { return }
        guard let titleL = titleLabel else { return }
        self.titleLabel?.lineBreakMode = .byTruncatingTail
        //获取图像的宽和高
        let imageWidth = imageV.frame.size.width
        let imageHeight = imageV.frame.size.height
        //获取文字的宽和高
        var labelWidth  = titleL.intrinsicContentSize.width
        var labelHeight = titleL.intrinsicContentSize.height
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        if #available(iOS 8, *) {
            labelWidth = titleL.intrinsicContentSize.width
            labelHeight = titleL.intrinsicContentSize.height
        } else {
            labelWidth = titleL.frame.size.width
            labelHeight = titleL.frame.size.height
        }
        
        if maxWidth > 0 {
            let max_labWidth = maxWidth - imageWidth - space
            if labelWidth > max_labWidth {
                labelWidth = titleL.frame.size.width
            }
        }
        
        switch style {
        case .left:
            //正常状态--只不过加了个间距
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space * 0.5, bottom: 0, right: space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space * 0.5, bottom: 0, right: -space * 0.5)
            if isAutoWidth == true {
                snp.makeConstraints { m in
                    m.width.equalTo(intrinsicContentSize.width + space)
                }
            }
        case .right:
            //切换位置--左文字右图像
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space * 0.5, bottom: 0, right: -labelWidth - space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - space * 0.5, bottom: 0, right: imageWidth + space * 0.5)
            if isAutoWidth == true {
                snp.makeConstraints { m in
                    m.width.equalTo(intrinsicContentSize.width + space)
                }
            }
        case .top:
            //切换位置--上图像下文字
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - space * 0.5, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight - space * 0.5, right: 0)
        case .bottom:
            //切换位置--下图像上文字
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight - space * 0.5, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight - space * 0.5, left: -imageWidth, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
    
    
}

@objc
extension UIButton {
    private struct AssociatedKeys {
        static var touchInsetsKey = UIEdgeInsets.zero
    }
    
    var touchInsets: UIEdgeInsets {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.touchInsetsKey) as? UIEdgeInsets ?? .zero
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.touchInsetsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    ///如果失效的话,监察是否有其他地方重写了这个方法
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let largerRect = bounds.inset(by: touchInsets.inverted())
        return largerRect.contains(point)
    }
}

extension UIEdgeInsets {
    func inverted() -> UIEdgeInsets {
        return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }
}
