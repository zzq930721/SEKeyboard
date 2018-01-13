//
//  SECommenFunction.swift
//  SEKeyBoard
//
//  Created by 曾宗全 on 2018/1/11.
//  Copyright © 2018年 juzhen. All rights reserved.
//

import UIKit

class SECommenFunction: NSObject {
    ///给一种颜色生成一张图片
    func createImageWithColor(_ color:UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    func randomArray(arr:Array<Any>) -> Array<Any> {
        var newArr = Array<Any>()
        var tmp = arr
        repeat {
            let randomIndex = arc4random_uniform(UInt32(tmp.count))
            let value = tmp[Int(randomIndex)]
            tmp.remove(at: Int(randomIndex))
            newArr.append(value)
            
        } while tmp.count > 0
       
//        print(newArr)
        return newArr
    }
    
    
    func transitionUppercaseAndLowerCase(isLower:Bool,arr:Array<String>) -> Array<String> {
        var newArr = Array<String>()
        if isLower {
            for str in arr {
               newArr.append(str.uppercased())
            }
        }else{
            for str in arr {
                newArr.append(str.lowercased())
            }
        }
        return newArr
    }
    
}


