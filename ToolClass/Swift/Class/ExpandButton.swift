//
//  ExpandButton.swift
//  ToolClass
//
//  Created by caidongdong on 2021/8/17.
//

import UIKit

class ExpandButton: UIButton {

    private var expandPrivateInsets: UIEdgeInsets = .zero
    
    var expandLeft: CGFloat {
        get { expandPrivateInsets.left }
        set { expandPrivateInsets.left = -newValue }
    }
    
    var expandRight: CGFloat {
        get { expandPrivateInsets.right }
        set { expandPrivateInsets.right = -newValue }
    }
    
    var expandTop: CGFloat {
        get { expandPrivateInsets.top }
        set { expandPrivateInsets.top = -newValue }
    }
    
    var expandBottom: CGFloat {
        get { expandPrivateInsets.bottom }
        set { expandPrivateInsets.bottom = -newValue }
    }
    
    var expandInsets: UIEdgeInsets {
        get { expandPrivateInsets }
        set { expandPrivateInsets = .init(top: -newValue.top, left: -newValue.left, bottom: -newValue.bottom, right: -newValue.right)}
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.inset(by: expandPrivateInsets).contains(point)
    }
}
