//
//  ViewController.swift
//  De
//
//  Created by admin 111 on 08/02/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let maFrame = CGRect(x: (self.view.frame.maxX-200) * 0.5, y: self.view.frame.maxY * 0.7, width: self.view.frame.width, height: 100)
        monLabel = UILabel(frame: maFrame)
        monLabel.numberOfLines = 0
        
    }

    @IBOutlet weak var dice_1: UIImageView!
    @IBOutlet weak var dice_2: UIImageView!
    @IBOutlet weak var label: UILabel!
    var monLabel: UILabel = UILabel()
    var rolling: Bool = false
    
    @IBAction func button(_ sender: UIButton) {
        if(rolling){
            sender.setTitle("Roll", for: .normal)
            rolling = false
        } else {
            sender.setTitle("Stop", for: .normal)
            rolling = true
            rollDice()
        }
        
        self.view.addSubview(monLabel)
    }
    
    
    @objc func rollDice(){
        let roll_1 = Int.random(in: 1...6)
        let roll_2 = Int.random(in: 1...6)
        
        monLabel.text = "Dice one : " + String(roll_1) + " Dice two : " + String(roll_2)
        
        dice_2.image = UIImage(named:String(roll_1))
        dice_1.image = UIImage(named:String(roll_2))
        
        if(roll_1 + roll_2 > 6 && !rolling){
            monLabel.text = monLabel.text! + "\nWin"
            return
        } else if(!rolling){
            monLabel.text = monLabel.text! + "\nLoose"
            return
        }
    
        self.perform(#selector(rollDice), with: nil, afterDelay: 0.1)
    }
    
}

