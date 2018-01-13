//
//  SESafeKeyBoard.swift
//  SEKeyBoard
//
//  Created by 曾宗全 on 2018/1/11.
//  Copyright © 2018年 juzhen. All rights reserved.
//

import UIKit

let screenW = UIScreen.main.bounds.size.width
//每行间距
let margin:CGFloat = 5
let iPhone4 = UIScreen.main.bounds.size.height == 480
let iPhone5 = UIScreen.main.bounds.size.height == 568
let iPhonePlus = UIScreen.main.bounds.size.height == 736
let iPhone6 = UIScreen.main.bounds.size.height == 667

enum kWordRandomType {
    case normal
    case fromStart
    case everyClick
}

class SESafeKeyBoard: UIView {
    
    var randomMode:kWordRandomType {
        didSet {
            englishPad.randomMode = randomMode
            numPad.randomMode = randomMode
        }
    }

    lazy var englishPad: SEEnglishPad = {
        let eng = SEEnglishPad(frame:self.bounds)
        eng.delegate = self
        eng.isHidden = true
        return eng
    }()
    
    lazy var numPad: SENumberPad = {
        let num = SENumberPad(frame:self.bounds)
        num.delegate = self
        return num
    }()

    override init(frame: CGRect) {
        randomMode = .normal
        super.init(frame: frame)
        backgroundColor = UIColor(red: 116/255.0, green: 144/255.0, blue: 194/255.0, alpha: 0.2)
        var rect = CGRect.zero;
        if (iPhone4 || iPhone5) {
            rect = CGRect(x: 0, y: 0, width: screenW, height: 180)
        }else if (iPhone6){
            rect = CGRect(x: 0, y: 0, width: screenW, height: 216)
        }else{
            rect = CGRect(x: 0, y: 0, width: screenW, height: 226)
        }
        self.frame = rect;
        addSubview(numPad)
        addSubview(englishPad)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SESafeKeyBoard:SENumberPadProtocol{
    func deleteClick(numPad: SENumberPad) {
        
    }
    
    func confirmClick(numPad: SENumberPad) {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    
    func changeEnglish(numPad: SENumberPad) {
        numPad.isHidden = true
        englishPad.isHidden = false
    }
    
    
//    func deleteClick(numPad: SENumberPad) {
//
//    }

  
}


extension SESafeKeyBoard:SEEnglishPadProtocol{
    func deleteClick(englishPad: SEEnglishPad) {
        
    }
    
    func changeNumber(englishPad: SEEnglishPad) {
        englishPad.isHidden = true
        numPad.isHidden = false
    }
    
    func confirmClick(englishPad: SEEnglishPad) {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    
    
    
    
}
