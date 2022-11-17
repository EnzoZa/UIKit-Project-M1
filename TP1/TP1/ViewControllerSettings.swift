//
//  ViewControllerSettings.swift
//  TP1
//
//  Created by admin 111 on 17/02/2022.
//

import UIKit

class ViewControllerSettings: UIViewController {

    var lat: UITextField?
    var long: UITextField?
    var send: UIButton?
    var vc: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.lat = UITextField(frame: CGRect(x: (self.view.frame.maxX-self.view.frame.width) * 0.5, y: (self.view.frame.maxY-self.view.frame.height*0.1) * 0.3, width: self.view.frame.width, height: self.view.frame.height*0.1) )
        self.lat!.placeholder = "latitude"
        self.lat!.textColor = .black
        self.lat!.backgroundColor = .lightGray
        self.lat!.textAlignment = .center
        self.lat!.font = self.lat!.font?.withSize(CGFloat(35))
        
        self.long = UITextField(frame: CGRect(x: (self.view.frame.maxX-self.view.frame.width) * 0.2, y: (self.view.frame.maxY-self.view.frame.height * 0.1) * 0.45, width: self.view.frame.width, height: self.view.frame.height * 0.1) )
        self.long!.placeholder = "longitude"
        self.long!.textColor = .black
        self.long!.backgroundColor = .lightGray
        self.long!.textAlignment = .center
        self.long!.font = self.long!.font?.withSize(CGFloat(35))

        self.send = UIButton(frame: CGRect(x: (self.view.frame.maxX-self.view.frame.width) * 0.2, y: (self.view.frame.maxY-self.view.frame.height * 0.1) * 0.75, width: self.view.frame.width, height: self.view.frame.height * 0.1)  )
        
        let config_option = UIImage.SymbolConfiguration(pointSize: CGFloat(30), weight: .bold, scale: .large)
        self.send!.setImage(UIImage(systemName: "play.fill", withConfiguration: config_option), for: UIControl.State.normal)
        self.send!.tintColor = .black
        
        self.view.addSubview(self.lat!)
        self.view.addSubview(self.long!)
        self.view.addSubview(self.send!)
        
        self.send?.addTarget(self, action: #selector(validateCoordinate), for: UIControl.Event.touchUpInside)
    }
    
    @IBAction func validateCoordinate(_ sender: UIButton){
        vc.setted_lat = self.lat!.text!
        vc.setted_long = self.lat!.text!
        self.dismiss(animated: true,completion: {
            self.vc?._reload()
        } )
    }
}
