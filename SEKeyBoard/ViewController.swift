//
//  ViewController.swift
//  SEKeyBoard
//
//  Created by 曾宗全 on 2018/1/11.
//  Copyright © 2018年 juzhen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let keyBoard = SESafeKeyBoard()
    
    @IBAction func normal(_ sender: Any) {
         keyBoard.randomMode = .normal
    }
    @IBAction func random(_ sender: Any) {
        keyBoard.randomMode = .fromStart
    }
    
    @IBAction func highRandom(_ sender: Any) {
        keyBoard.randomMode = .everyClick
    }
    @IBOutlet weak var textF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        textF.inputView = keyBoard
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }


}

