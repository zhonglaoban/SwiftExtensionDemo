//
//  UIView+zf.swift
//  Extension
//
//  Created by 钟凡 on 2017/9/21.
//  Copyright © 2017年 钟凡. All rights reserved.
//

import Foundation
import UIKit

// 会返回自身，相当于rx里面的base（number1.rx.base）
protocol ZFInstance {
    associatedtype DT
    var instance: DT { get }
}
// 我觉得像是命名空间，相当于RxSwift里面的rx
protocol ZFNameSpace {
    associatedtype DT
    
    var zf: DT { get }
}
// 相当于RxSwift里面的Reactive
public final class ZFBase<T>: ZFInstance {
    typealias DT = T
    
    public let instance:T
    public init(instance:T) {
        self.instance = instance
    }
}
// Int
extension Int: ZFNameSpace {
    var zf:ZFBase<Int> {
        return ZFBase(instance: self)
    }
}

extension ZFInstance where DT == Int {
    var doubleValue:String {
        let value = instance * 2
        return "\(instance) + \(instance) = \(value)"
    }
}
// String
extension String: ZFNameSpace {
    var zf:ZFBase<String> {
        return ZFBase(instance: self)
    }
}

extension ZFInstance where DT == String {
    var hello:String {
        return "hello," + instance
    }
}
// UIView
extension UIView: ZFNameSpace {
    var zf:ZFBase<UIView> {
        return ZFBase(instance: self)
    }
}

extension ZFInstance where DT == UIView {
    var viewName:String {
        return instance.description
    }
}
