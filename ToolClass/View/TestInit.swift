//
//  TestInit.swift
//  ToolClass
//
//  Created by zhuzi-cdd on 2024/6/20.
//

import UIKit

class TestInit: UIView {
    
    var my_height: CGFloat
    
    init(height: CGFloat) {
        self.my_height = height
        super.init(frame: .zero )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
