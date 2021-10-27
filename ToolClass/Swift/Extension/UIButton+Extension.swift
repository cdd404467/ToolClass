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
        imagePosition(at: style, space: space, isAutoWidth: false)
    }
    
    @objc func imagePosition(at style: ButtonImageEdgeInsetsStyle, space: CGFloat, isAutoWidth: Bool = false) {
        guard let imageV = imageView else { return }
        guard let titleL = titleLabel else { return }
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
        
        
        switch style {
        case .left:
            //正常状态--只不过加了个间距
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space * 0.5, bottom: 0, right: space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space * 0.5, bottom: 0, right: -space * 0.5)
            if isAutoWidth == true {
                snp.updateConstraints { m in
                    m.width.equalTo(intrinsicContentSize.width + space)
                }
            }
        case .right:
            //切换位置--左文字右图像
            //图像：UIEdgeInsets的left是相对于UIButton的左边移动了labelWidth + space * 0.5，right相对于label的左边移动了-labelWidth - space * 0.5
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space * 0.5, bottom: 0, right: -labelWidth - space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - space * 0.5, bottom: 0, right: imageWidth + space * 0.5)
            if isAutoWidth == true {
                snp.updateConstraints { m in
                    m.width.equalTo(intrinsicContentSize.width + space)
                }
            }
        case .top:
            //切换位置--上图像下文字
            /**图像的中心位置向右移动了labelWidth * 0.5，向上移动了-imageHeight * 0.5 - space * 0.5
             *文字的中心位置向左移动了imageWidth * 0.5，向下移动了labelHeight*0.5+space*0.5
            */
            imageEdgeInsets = UIEdgeInsets(top: -imageHeight * 0.5 - space * 0.5, left: labelWidth * 0.5, bottom: imageHeight * 0.5 + space * 0.5, right: -labelWidth * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: labelHeight * 0.5 + space * 0.5, left: -imageWidth * 0.5, bottom: -labelHeight * 0.5 - space * 0.5, right: imageWidth * 0.5)
        case .bottom:
            //切换位置--下图像上文字
            /**图像的中心位置向右移动了labelWidth * 0.5，向下移动了imageHeight * 0.5 + space * 0.5
             *文字的中心位置向左移动了imageWidth * 0.5，向上移动了labelHeight*0.5+space*0.5
             */
            imageEdgeInsets = UIEdgeInsets(top: imageHeight * 0.5 + space * 0.5, left: labelWidth * 0.5, bottom: -imageHeight * 0.5 - space * 0.5, right: -labelWidth * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: -labelHeight * 0.5 - space * 0.5, left: -imageWidth * 0.5, bottom: labelHeight * 0.5 + space * 0.5, right: imageWidth * 0.5)
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
    
    
}

extension UIButton {

    
    
    
    

}
