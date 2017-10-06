//
//  ViewController.swift
//  Multiplier
//
//  Created by Sandeep Chhabra on 06/10/17.
//  Copyright © 2017 SandeepChhabra. All rights reserved.
//

import UIKit


enum Direction {
    case front
    case rear
}

class ViewController: UIViewController {

    @IBOutlet weak var num1TxtField: UITextField!
    
    @IBOutlet weak var num2TxtField: UITextField!
    
    @IBOutlet weak var resulTxtView: UITextView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func multiplyNumbers(_ sender: Any) {
    
      self.view.endEditing(true)
      resulTxtView.text = multiplyStrings(string1: num1TxtField.text!, string2: num2TxtField.text!)
        
    }

    
    func multiplyStrings(string1:String,string2:String) -> String {
        var resultArray:[String] = Array()
        
        var count = string2.characters.count - 1

        var numberOfZeros = 0
        
        while count >= 0 {
            var res = multiply(string: string1, singleCharacter: string2[count])
            res = appendZeros(in: res, count: numberOfZeros, dir: .rear)//(count: numberOfZeros, string: res)
            res = appendZeros(in: res, count: count, dir: .front)
            resultArray.append(res)
            count -= 1
            numberOfZeros += 1
        }
        print("Addition Array = \(resultArray.description)")
        return add(strings:resultArray )
    }
    
    func multiply(string:String, singleCharacter:String ) -> String {
        
        var count = string.characters.count - 1
        var carry = 0
        
        var resultstring = ""
        
        while count >= 0 {
           
            let num1 = string[count]
            let num2 = singleCharacter
            
            let res = ( Int(num1)! * Int(num2)!) + carry
            
            let val = Int(res%10)
            resultstring.insert(Character.init("\(val)") , at: resultstring.startIndex)
            
            carry = Int(res/10)
            count -= 1
        }
        
        if carry != 0{
            resultstring.insert(Character.init("\(carry)") , at: resultstring.startIndex)
        }
        
        return resultstring
    }
    
    func appendZeros(in string:String, count:Int,dir:Direction) -> String {
        if var resultStr = String.init(string){
            if count == 0{
                return resultStr
            }
            dir == .rear ? resultStr.append("0") : resultStr.insert(Character.init("0"), at: resultStr.startIndex)
            
            return appendZeros(in: resultStr, count: count - 1, dir: dir)
        }
        else {
            return string
        }
    }
    
    func add(strings:[String]) -> String {
        
        
            var resultStr = ""
            var carry = 0
            
            var lenthCounter  = strings[0].length - 1
            
            while lenthCounter >= 0 {
                var tempSum = 0
                
                for  count in  0 ... (strings.count - 1) {
                    let str = strings[count]
                    tempSum += Int( str[lenthCounter])!
                }
                
                tempSum += carry
                carry = tempSum/10
                tempSum = tempSum%10
                
                resultStr.insert(Character.init("\(tempSum)") , at: resultStr.startIndex)
                lenthCounter -= 1
            }
            
            if carry != 0{
                resultStr.insert(Character.init("\(carry)") , at: resultStr.startIndex)
            }
            
            return resultStr
        
    }
    
    
    
//    func performMathOperation(type:operationType,num1:String,num2:String) -> (carry:String,val:String) {
//       
//        switch type {
//        case .multiply:
//            let res = Int(num1)! * Int(num2)!
//            let carry = Int(res/10)
//            let val = Int(res%10)
//            return ("\(carry)","\(val)")
//        case .add:
//            let res = Int(num1)! + Int(num2)!
//            let carry = Int(res/10)
//            let val = Int(res%10)
//            return ("\(carry)","\(val)")
//        }
//    }
//    
}

