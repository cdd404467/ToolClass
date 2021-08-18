//
//  PadLabel.swift
//  LiveShopUserProject
//
//  Created by caidongdong on 2021/6/30.
//

import Foundation

@IBDesignable
class PaddingLabel: UILabel{

    private var padding = UIEdgeInsets.zero
    @IBInspectable
    var paddingLeft: CGFloat {
        get { return padding.left }
        set { padding.left = newValue }
    }
   
    @IBInspectable
    var paddingRight: CGFloat {
        get { return padding.right }
        set { padding.right = newValue }
    }
    
    @IBInspectable
    var paddingTop: CGFloat {
        get { return padding.top }
        set { padding.top = newValue }
    }
    
    @IBInspectable
    var paddingBottom: CGFloat {
        get { return padding.bottom }
        set { padding.bottom = newValue}
    }
    
    @IBInspectable
    var contentInsets: UIEdgeInsets {
        get {return padding}
        set {padding = newValue}
    }
    
    //重新绘制文本
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    //重新text文字框大小
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = self.padding
        var rect = super.textRect(forBounds:bounds.inset(by: insets), limitedToNumberOfLines: numberOfLines)
        rect.origin.x -= insets.left
        rect.origin.y -= insets.top
        rect.size.width += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        return rect
    }
    
    override var text: String? {
        didSet {
            isHidden = !Help.isRightData(text)
        }
    }
}
