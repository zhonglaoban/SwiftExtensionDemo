# SwiftExtensionDemo
最近在学习RxSwift，看到里面这种number1.rx.text.orEmpty写法感到很神奇：
```swift
class NumbersViewController: ViewController {
@IBOutlet weak var number1: UITextField!
@IBOutlet weak var number2: UITextField!
@IBOutlet weak var number3: UITextField!

@IBOutlet weak var result: UILabel!

override func viewDidLoad() {
super.viewDidLoad()

Observable.combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
}
.map { $0.description }
.bind(to: result.rx.text)
.disposed(by: disposeBag)
}
}
```
于是就研究写了一下：
```swift
import Foundation
import UIKit

// 会返回自身，相当于rx里面的base（number1.rx.base）
protocol ZFInstance {
associatedtype DT
var instance: DT { get }
}
// 像是命名空间，相当于RxSwift里面的rx
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
```
```swift
let v = UIView()

print(v.zf.viewName)
print(1.zf.doubleValue)
print("fan".zf.hello)
print(v.zf.instance)
```
打印结果：
```
<UIView: 0x7fd23bf0cab0; frame = (0 0; 0 0); layer = <CALayer: 0x608000038d00>>
1 + 1 = 2
hello,fan
```
这么写有什么好处呢，或者说不这样写有什么缺点：
1、项目组内谁都可以写扩展，如果没有很好的沟通或管理，那么会出现很多功能相似的扩展，会导致一些沟通上，重复代码，维护困难等问题。
2、可能造成一些命名冲突。
3、将不同的功能组织的代码放在不同的空间里。
