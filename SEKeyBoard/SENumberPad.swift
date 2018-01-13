//
//  SENumberPad.swift
//  SEKeyBoard
//
//  Created by 曾宗全 on 2018/1/11.
//  Copyright © 2018年 juzhen. All rights reserved.
//

import UIKit




protocol SENumberPadProtocol:NSObjectProtocol {
    func changeEnglish(numPad:SENumberPad)
    func confirmClick(numPad:SENumberPad)
    func deleteClick(numPad:SENumberPad)
  
}

class SENumberPad: UIView {
    //总行数
    let maxRows:CGFloat = 4
    //总列数
    let maxCols:CGFloat = 4
    
    var randomMode:kWordRandomType?{
        didSet{
            if randomMode == .fromStart || randomMode == .everyClick {
                var num = ["1","2","3","4","5","6","7","8","9","0"]
                num = SECommenFunction().randomArray(arr: num) as! [String]
                print(btnArray.count)
                for i in 0..<btnArray.count {
                    let btn = btnArray[i]
                    btn.setTitle(num[i], for: .normal)
                }
            }
        }
    }
    
    lazy var numArray = ["1","2","3","4","5","6","7","8","9","ABC","0","."]
    lazy var btnArray = Array<UIButton>()
    lazy var responder: Any? = {
        let firstResponder = UIApplication.shared.keyWindow?.value(forKey:"firstResponder")
        return firstResponder
    }()
    weak var delegate:SENumberPadProtocol?
    var numView:UIView?
    var funcView:UIView?
    
    
    override init(frame: CGRect) {
        randomMode = .normal
        super.init(frame: frame);
        let height = frame.size.height
        let btnH = (height - (maxRows + 1) * margin) / maxRows
        let btnW = (screenW - (maxCols + 1) * margin) / maxCols
        let numF = CGRect(x: 0, y: 0, width: maxCols * margin + (maxCols - 1) * btnW, height: height)
        numView = UIView(frame: numF)
        addSubview(numView!)
        //添加数字键
        for i in 0..<12 {
            let col = CGFloat(i % Int(maxCols - 1))
            let btnX = margin + (btnW + margin) * col
            let row = CGFloat(i / Int(maxCols - 1))
            let btnY = margin + (btnH + margin) * row
            let rect = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            let btn = SEKeyBoardButton(frame: rect, title: numArray[i])
            if (i != 9) {
                btn.addTarget(self, action:#selector(numClick) , for: .touchUpInside)
                if (i != 11) { btnArray.append(btn) }
            }else{
                btn.addTarget(self, action: #selector(changeEnglish), for: .touchUpInside)
            }
           
            numView?.addSubview(btn)
           
        }
        
        let funcF = CGRect(x:numF.size.width, y: 0, width: screenW - numF.size.width, height: height)
        funcView = UIView(frame:funcF)
        addSubview(funcView!)
        
        //添加删除键
        let delF = CGRect(x: 0, y: margin, width: btnW, height: btnH)
        let delBtn = SEKeyBoardButton(frame: delF, title: "")
        delBtn.addTarget(self, action: #selector(deleteChar), for: .touchUpInside)
        delBtn.setImage(UIImage(named: "image.bundle/delete.png", in: nil, compatibleWith: nil), for: .normal)
        delBtn.imageEdgeInsets = UIEdgeInsets(top: 13, left: 25, bottom: 13, right: 25)
        funcView?.addSubview(delBtn)
        
        //添加确定键
        let confF = CGRect(x: 0, y: btnH + 2 * margin, width: btnW, height: btnH * 3 + 2 * margin)
        let confBtn = SEKeyBoardButton(frame: confF, title: "完成")
        confBtn.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        funcView?.addSubview(confBtn)
        
       
    }
    
    
   @objc func numClick(sender:UIButton) {
        if( responder is UITextField ){
            let resp = responder as! UITextField
            guard let s = sender.titleLabel?.text else {
                return
            }
            resp.text = resp.text?.appending(s)
        }
    }
    
    @objc func changeEnglish(sender:UIButton) {
        delegate?.changeEnglish(numPad: self)
    }
    
    @objc func deleteChar(sender:UIButton) {
        if( responder is UITextField ){
            let resp = responder as! UITextField
            let text = resp.text! as NSString
            if text.length != 0 {
                resp.text = text.substring(to: text.length - 1)
            }
        }
        delegate?.deleteClick(numPad: self)
    }
    
    @objc func confirm(sender:UIButton){
        delegate?.confirmClick(numPad: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}


