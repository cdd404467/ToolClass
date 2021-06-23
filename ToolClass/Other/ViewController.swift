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
        
        
        
        
        
        test()
    }

    
    func test() {
        let btn = UIButton.init(type: .custom)
        view.addSubview(btn)
        btn.frame = CGRect.init(x: 50, y: 100, width: 100, height: 100)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(jump), for: .touchUpInside)
        
    }

    
    @objc
    func jump() {
        navigationController?.pushViewController(Test1VC.init(), animated: true)
    }
    
}

