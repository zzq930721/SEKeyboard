//
//  SEEnglishPad.swift
//  SEKeyBoard
//
//  Created by 曾宗全 on 2018/1/11.
//  Copyright © 2018年 juzhen. All rights reserved.
//

import UIKit

@objc protocol SEEnglishPadProtocol:NSObjectProtocol {
    func changeNumber(englishPad:SEEnglishPad)
    func confirmClick(englishPad:SEEnglishPad)
    func deleteClick(englishPad:SEEnglishPad)
}

class SEEnglishPad: UIView {
    let maxRows:CGFloat = 4
    lazy var charArray = ["q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m"]
    lazy var btnArray = Array<UIButton>()
    
    weak var delegate:SEEnglishPadProtocol?
    
    lazy var responder: Any? = {
        let firstResponder = UIApplication.shared.keyWindow?.value(forKey:"firstResponder")
        return firstResponder
    }()
    
    var randomMode:kWordRandomType? {
        didSet{
            if randomMode == .fromStart || randomMode == .everyClick {
                charArray = SECommenFunction().randomArray(arr: charArray) as! [String]
                setWord()
            }
        }
    }
    
    
    override init(frame: CGRect) {
        randomMode = .normal
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWord() {
        print(btnArray.count)
        for i in 0..<26 {
            let btn = btnArray[i]
            btn.setTitle(charArray[i], for: .normal)
        }
    }
    
    func setupUI() {
        //第一行10个按钮
        let btnW = (screenW - 11 * margin) / 10
        let height = frame.size.height
        let btnH = (height - (maxRows + 1) * margin) / maxRows
        for i in 0..<10 {
            let btnX = margin + (margin + btnW) * CGFloat(i)
            let btnY = margin;
            let rect = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            let btn = SEKeyBoardButton(frame: rect, title:charArray[i])
            btn.addTarget(self, action:#selector(wordClick) , for: .touchUpInside)
            btnArray.append(btn)
            addSubview(btn)
        }
        
        //第二行9个按钮
        var newMargin = (screenW - (9 * btnW + 8 * margin)) / 2
        for i in 0..<9 {
            let btnX = newMargin + (margin + btnW) * CGFloat(i)
            let btnY = margin + margin + btnH;
            let rect = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            let btn = SEKeyBoardButton(frame: rect, title: charArray[i + 10])
            btn.addTarget(self, action:#selector(wordClick) , for: .touchUpInside)
            btnArray.append(btn)
            addSubview(btn)
        }
        
        // 第三行8个按钮
        newMargin = (screenW - (7 * btnW + 6 * margin)) / 2
        for i in 0..<7 {
            let btnX = newMargin + (margin + btnW) * CGFloat(i)
            let btnY = margin + (margin + btnH) * 2
            let rect = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            let btn = SEKeyBoardButton(frame: rect, title: charArray[i + 19])
            btn.addTarget(self, action:#selector(wordClick) , for: .touchUpInside)
            btnArray.append(btn)
            addSubview(btn)
        }
        //大写键
        let upW = newMargin - margin * 2
        let upF = CGRect(x: margin, y:margin + (margin + btnH) * 2 , width: upW, height: btnH)
        let upBtn = SEKeyBoardButton(frame: upF, title: "")
        upBtn.addTarget(self, action: #selector(upCase), for: .touchUpInside)
        upBtn.setImage(UIImage(named: "image.bundle/shift.png", in: nil, compatibleWith: nil), for: .normal)
        let backImage = SECommenFunction().createImageWithColor(UIColor(red:0.66, green:0.69, blue:0.73, alpha:1.00))
        upBtn.setBackgroundImage(backImage, for: .selected)
        addSubview(upBtn)
        
        //删除键
        let delF = CGRect(x:2 * margin + upW + 7 * (margin + btnW) , y:margin + (margin + btnH) * 2 , width: upW, height: btnH)
        let delBtn = SEKeyBoardButton(frame: delF, title: "")

        delBtn.setImage(UIImage(named: "image.bundle/delete.png", in: nil, compatibleWith: nil), for: .normal)
        delBtn.imageEdgeInsets = UIEdgeInsets(top: 13, left: 8, bottom: 13, right: 8)
//        btnArray.append(delBtn)
        delBtn.addTarget(self, action: #selector(deleteChar), for: .touchUpInside)
        addSubview(delBtn)
        
        //切换键
        let changeW = 2.5 * btnW
        let changeF = CGRect(x: margin, y: margin + (margin + btnH) * 3, width: changeW, height: btnH)
        let changeBtn = SEKeyBoardButton(frame: changeF, title: "123")
        
        changeBtn.addTarget(self, action: #selector(changeNumber), for: .touchUpInside)
//        btnArray.append(changeBtn)
        addSubview(changeBtn)
        
        //空格
        let spaceW = screenW - 2 * changeW - 4 * margin
        let spaceF = CGRect(x: changeW + 2 * margin, y: changeF.origin.y, width: spaceW, height: btnH)
        let spaceBtn = SEKeyBoardButton(frame: spaceF, title: "space")
        spaceBtn.addTarget(self, action:#selector(wordClick) , for: .touchUpInside)
        addSubview(spaceBtn)
        
        //确认
        let conF = CGRect(x: changeW + 3 * margin + spaceW, y: margin + (margin + btnH) * 3, width: changeW, height: btnH)
        let confBtn = SEKeyBoardButton(frame: conF, title: "确定")
        confBtn.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        addSubview(confBtn)
        
    }
    
   

}


// MARK: - Actions
extension SEEnglishPad{
    
    @objc func wordClick(sender:UIButton) {
        if( responder is UITextField ){
            let resp = responder as! UITextField
            guard let s = sender.titleLabel?.text else {
                return
            }
            if s == "space" {
                resp.text = resp.text?.appending(" ")
            }else{
                resp.text = resp.text?.appending(s)
            }
        }
        
        if randomMode == .everyClick {
            charArray = SECommenFunction().randomArray(arr: charArray) as! [String]
            setWord()
        }
        
        
        
    }
    
    @objc func changeNumber(sender:UIButton) {
        delegate?.changeNumber(englishPad: self)
    }
    
    @objc func confirm(sender:UIButton){
        delegate?.confirmClick(englishPad: self)
    }
    
    @objc func deleteChar(sender:UIButton) {
        if( responder is UITextField ){
            let resp = responder as! UITextField
            let text = resp.text! as NSString
            if text.length != 0 {
                resp.text = text.substring(to: text.length - 1)
            }
        }
        delegate?.deleteClick(englishPad: self)
    }
    
    @objc func upCase(sender:UIButton) {
        sender.isSelected = !sender.isSelected
        //选中大写
        charArray = SECommenFunction().transitionUppercaseAndLowerCase(isLower: sender.isSelected, arr: charArray)
        setWord()
    }
}
