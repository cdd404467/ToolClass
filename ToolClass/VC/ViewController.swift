//
//  ViewController.swift
//  ToolClass
//
//  Created by caidongdong on 2021/6/3.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "首页"
        
        print(NSString.correctPrecision("1.88888888888"))
        test()
        
        
        
    }

    
    func test() {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "icon_test1"), for: .normal)
        btn.setTitle("我的", for: .normal)
        view.addSubview(btn)
        btn.frame = CGRect.init(x: 10, y: 100, width: 100, height: 100)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(jump), for: .touchUpInside)
//        btn.imagePosition(at: .right, space: 10)
        btn.layout(with: ButtonEdgeInsetsStyle.left, imageTitleSpace: 10)
        
    }

    
    @objc
    func jump() {
        navigationController?.pushViewController(Test1VC.init(), animated: true)
    }
    
}

