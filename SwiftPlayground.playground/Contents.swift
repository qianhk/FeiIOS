//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

var myVariable = 42
myVariable = 50
myVariable
let myConst = 42
var explicitFloat: Float = 4
explicitFloat = 5.2

let str = "TestString"
print("hello world, kai" + " " + str + " " + String(explicitFloat) + " \(myConst + Int(explicitFloat))");


let quotation = """
I said "Ihave \(myConst) apples."
haha and you
"""
print(quotation)

var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"

var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"

var optionalString: String? = "Hello"
print(optionalString == nil)

var optionalName: String? = nil//"John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
} else {
    print("optionName is nil")
}

var varName = optionalName ?? "kaikaiReplace"

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
