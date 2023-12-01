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
        lab.superview?.layoutIfNeeded()
        
        let v = UIView()
        v.backgroundColor = .red
        v.frame = CGRect(x: lab.left, y: lab.bottom, width: lab.width, height: lab.height / 2)
        view.addSubview(v)
        
        
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
//        print("--- \(b)")
        
        
        let digitNames = [
             0: "Zero",1: "One",2: "Two",  3: "Three",4: "Four",
             5: "Five",6: "Six",7: "Seven",8: "Eight",9: "Nine"
          ]
        
        var num = 1993
        var output = ""
        var tempNum : Int
        
//        String(num)
        
        repeat {
            tempNum = num % 10
            output = digitNames[tempNum]! + output
            num = num / 10
        } while num > 0
        
        
        
        print("最后输出的是：\n\(output)")
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



