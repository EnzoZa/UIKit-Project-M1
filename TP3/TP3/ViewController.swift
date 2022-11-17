//
//  ViewController.swift
//  TP3
//
//  Created by admin 111 on 17/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    var scroll: UIScrollView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    func getMultipleOf2() {
        let nbIteration = 10000
        
        for i in 0...nbIteration {
            let tempView = UIView(frame: CGRect(x: 0, y: 50*CGFloat(i), width: self.view.frame.width, height:50) )
            
            let labelTemp = UILabel(frame : CGRect(x: (tempView.frame.maxX)*0.5, y: (tempView.frame.height*CGFloat(i)), width: tempView.frame.width, height:tempView.frame.height)  )
            
            labelTemp.text = String(i*2)
            tempView.addSubview(labelTemp)
            self.scroll!.addSubview(tempView)
        }
        
        self.scroll!.contentSize = CGSize(width: CGFloat(self.view.frame.maxX), height: CGFloat(nbIteration * 50))
        
    }
    
    func setup() {
        self.scroll = UIScrollView(frame: CGRect(x: (self.view.frame.maxX-self.view.frame.width), y: (self.view.frame.maxY-self.view.frame.height), width: self.view.frame.width, height: self.view.frame.height) )
        scroll?.backgroundColor = #colorLiteral(red: 0.244119898, green: 0.2466378145, blue: 1, alpha: 1)
        
        self.view.addSubview(self.scroll!)
        
        getMultipleOf2()
    }


}

