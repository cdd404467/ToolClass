//
//  ViewController.swift
//  ToolClass
//
//  Created by caidongdong on 2021/6/3.
//

import UIKit

class ViewController: UIViewController {

    var pp: CGSize = CGSize.zero
    var nameStr: String = "" {
        didSet {
            self.nameStr = "333"
        }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "首页"
        
        let lab: UIButton = UIButton.init()
        lab.backgroundColor = .gray
        lab.addTarget(self, action: #selector(jump), for: .touchUpInside)
        view.addSubview(lab)
        lab.snp.makeConstraints { make in
            make.left.equalTo(50)
            make.top.equalTo(100)
            make.width.height.equalTo(100)
        }
        
        
        
        var arr = [1,2,3,4,5,6]
        var arr_1: [Int] {
            get {
                for i in 0..<arr.count {
                    if i % 2 == 0 {
                        arr.swapAt(i, i+1)
                    }
                    
                }
                return arr
            }
            set {}
        }
        
        
        
        
        
      
//
//        if #available(iOS 8, *) {
//            if (pp == CGSize.zero) {
//                print("1111")
//            }
//            if (__CGSizeEqualToSize(pp , CGSize.init(width: 20, height: 20))) {
//                print("2222")
//            }
//        }
        print("--- \(b)")
        
    }
    
    
    var a: Int {
        if SCREEN_WIDTH > 300 {
            return 3
        } else {
            return 4
        }
    }
    
    var b: Int {
        
        let c = a
        if SCREEN_WIDTH > 500 {
            return c
        } else {
            return 5
        }
    }
    
    
    
    func cdd() -> Int {
        return 1
    }
    
    func cdd1() -> Int {
        let _ = cdd()
        
        return 2
    }

    
    func test() {
        let btn = ExpandButton.init(type: .custom)
        
        btn.expandLeft = 10
        btn.setImage(UIImage.init(named: "icon_test1"), for: .normal)
        btn.setTitle("我哈哈的", for: .normal)
        view.addSubview(btn)
        btn.frame = CGRect.init(x: 110, y: 400, width: 100, height: 100)
        btn.backgroundColor = .red
//        btn.imagePosition(at: .left, space: 50)
        btn.addTarget(self, action: #selector(jump), for: .touchUpInside)
        btn.snp.makeConstraints { m in
            m.left.equalTo(110)
            m.width.greaterThanOrEqualTo(10)
            m.top.equalTo(400)
        }
        
//        print(btn.intrinsicContentSize)
//        btn.setTitle("我的我的我的我的我的", for: .normal)
//        btn.imagePosition(at: .left, space: 50)
    }

    
    @objc
    func jump() {
        print("---- pppp")
        navigationController?.pushViewController(Test1VC.init(), animated: true)
    }
    
}



