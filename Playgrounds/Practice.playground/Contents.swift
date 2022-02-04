import UIKit

////Loops
//var myNumber = 1
//
//myNumber += 1
//
//var number = 0
//
//while number < 10 {
////    print(number)
//    number += 1
//}
//
//var characterAlive = true
//
//while characterAlive == true {
////    print("character alive")
//    characterAlive = false
//}
//
//var myFruits = ["Banan", "Armud", "Alma"]
//
//for fruit in myFruits {
//   print(fruit)
//}
//
//var numbers = [10,20,30,40,50]
//
//for n in numbers{
//    let answer = n/5
//    print(answer)
//}
//
//for myNewInteger in 1 ... 5 {
//    print(myNewInteger)
//}
//
//
//var myAge = -1
//
//if myAge >= 18{
//    print("18 or 18+")
//} else if myAge < 0 {
//    print("new error")
//} else {
//    print("Error")
//}
//
//var myString = "James"
//if myString == "James" {
//    print(true)
//} else {
//    print(false)
//}

//Functions

func myFunction(){
    print("my function")
}

myFunction()

func sumFunction(x: Int, y: Int) -> Int{
    return x + y
}

sumFunction(x: 10, y: 20)

var myFunctionVariables = sumFunction(x: 10, y: 15)
print(myFunctionVariables)

func logicFunction(x: Int, y: Int) -> Bool {
    if x == y {
        return true
        
    } else {
        return false
        
    }
    
    
    
}

logicFunction(x: 10, y: 20)
