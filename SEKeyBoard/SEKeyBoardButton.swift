//
//  SEKeyBoardButton.swift
//  SEKeyBoard
//
//  Created by 曾宗全 on 2018/1/11.
//  Copyright © 2018年 juzhen. All rights reserved.
//

import UIKit

class SEKeyBoardButton: UIButton {
    
    
    
    init(frame:CGRect,title:String) {
        super.init(frame: frame)
        setTitle(title, for: .normal)
//        self.tag = tag
        backgroundColor = UIColor.white
        setTitleColor(UIColor.black, for: .normal)
        layer.cornerRadius = 5
        layer.masksToBounds = true
        let backImage = SECommenFunction().createImageWithColor(UIColor(red:0.66, green:0.69, blue:0.73, alpha:1.00))
        setBackgroundImage(backImage, for: .highlighted)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
