//
//  String+Extension.swift
//  ToolClass
//
//  Created by caidongdong on 2021/6/3.
//

import Foundation
//解决小数点失真
public extension String {
    @discardableResult
    func correctPrecision(_ money: String) -> String {
        if Help.isRightData(money) {
            return ""
        }
        let conversionValue: Double = Double(money) ?? 0
        let doubleString = String.init(format: "%.2lf", conversionValue)
        let decNumber = Decimal.init(string: doubleString)
        return decNumber!.description
    }
    
}

public extension NSString {
    @discardableResult
    @objc class func correctPrecision(_ money: NSString) -> NSString {
        if Help.isRightData(money) {
            return ""
        }
        let conversionValue: Double = Double(money as Substring) ?? 0
        let doubleString = String.init(format: "%.2lf", conversionValue)
        let decNumber = Decimal.init(string: doubleString)
        return decNumber!.description as NSString
    }
}

//截取字符串分类
extension String {
    //string[index]
    public subscript(index: Int) -> String {
        let character = self[self.index(startIndex, offsetBy: index)]
        return String(character)
    }
    
    //string[index..<index]
    public subscript(bounds: CountableRange<Int>) -> String {

        let string = self[index(startIndex, offsetBy: bounds.lowerBound) ..< index(startIndex, offsetBy: bounds.upperBound)]
        return String(string)
//        let startIndex = self.index(self.startIndex, offsetBy: bounds.lowerBound)
//        let endIndex = self.index(self.startIndex, offsetBy: bounds.upperBound)
//        return String(self[startIndex..<endIndex])
    }
    
    //string[index...index]
    public subscript(bounds: CountableClosedRange<Int>) -> String {
        let string = self[index(startIndex, offsetBy: bounds.lowerBound) ... index(startIndex, offsetBy: bounds.upperBound)]
        return String(string)
    }
      
    //string[index,length]
    public subscript (index: Int , length: Int) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let endIndex = self.index(startIndex, offsetBy: length)
            return String(self[startIndex..<endIndex])
        }
    }
    
    //截取从头到i位置
    public func substring(to: Int) -> String{
        return self[0..<to]
    }
    
    //截取从i到尾部
    public func substring(from: Int) -> String{
        return self[from..<self.count]
    }
    
}
