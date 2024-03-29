//
//  UITableView+Extension.swift
//  full_lease_landlord
//
//  Created by apple on 2021/1/12.
//  Copyright © 2021 apple. All rights reserved.
//

import Foundation

public extension UITableView {
    
    final func cddDequeueReusableCell<T: UITableViewCell>(cellType: T.Type = T.self) -> T {
        let reuseIdentifier = String(describing: cellType.self)
        var cell = self.dequeueReusableCell(withIdentifier: reuseIdentifier) as? T
        if cell == nil {
            cell = cellType.init(style: .default, reuseIdentifier: reuseIdentifier)
        }
        cell?.selectionStyle = .none
        
        return cell!
    }
    
    final func register<T: UITableViewCell>(cellType: T.Type = T.self) {
        self.register(cellType.self, forCellReuseIdentifier: String(describing: cellType.self))
    }
      
    final func cddDequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>(viewType: T.Type = T.self) -> T {
        let reuseIdentifier = String(describing: viewType.self)
        var view = self.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as? T
        if view == nil {
            view = viewType.init(reuseIdentifier: reuseIdentifier)
        }
        return view!
    }
    
    
    
//    final func cddDequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
//    where T: Reusable {
//      guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
//        fatalError(
//          "注册cell失败 \(cellType.reuseIdentifier) cell类型 \(cellType.self). "
//        )
//      }
//      return cell
//    }
    
    
}

public protocol Reusable: AnyObject {
  /// The reuse identifier to use when registering and later dequeuing a reusable cell
    static var reuseIdentifier: String { get }
}

/// Make your `UITableViewCell` and `UICollectionViewCell` subclasses
/// conform to this typealias when they *are* NIB-based
/// to be able to dequeue them in a type-safe manner
//public typealias NibReusable = Reusable & NibLoadable
//public typealias NibReusable = Reusable

// MARK: - Default implementation

public extension Reusable {
  /// By default, use the name of the class as String for its reuseIdentifier
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
