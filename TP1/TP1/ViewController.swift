//
//  ViewController.swift
//  TP1
//
//  Created by admin 111 on 08/02/2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var weather_image: UIImageView?
    var city: UILabel?
    var temp: UILabel?
    var time: UILabel?
    var refresh: UIButton?
    var option: UIButton?
    var locationManager: CLLocationManager!
    var coordinate: CLLocationCoordinate2D!
    var setted_lat: String?
    var setted_long: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        becomeFirstResponder()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemGreen
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.requestWhenInUseAuthorization()
        locationManager!.startUpdatingLocation()
        
        self.weather_image = UIImageView(frame: CGRect(x: (self.view.frame.maxX-self.view.frame.width*0.55) * 0.5, y: (self.view.frame.maxY-self.view.frame.height*0.25) * 0.3, width: self.view.frame.width*0.55, height: self.view.frame.height*0.25) )
        self.weather_image?.contentMode = .scaleAspectFit
        
        self.city = UILabel(frame: CGRect(x: (self.view.frame.maxX-self.view.frame.width) * 0.2, y: (self.view.frame.maxY-self.view.frame.height * 0.1) * 0.15, width: self.view.frame.width, height: self.view.frame.height * 0.1) )
        self.city!.text = ""
        self.city!.textAlignment = .center
        self.city!.font = self.city!.font.withSize(CGFloat(35))
        
        self.temp = UILabel(frame: CGRect(x: (self.view.frame.maxX-self.view.frame.width) * 0.2, y: (self.view.frame.maxY-self.view.frame.height * 0.1) * 0.55, width: self.view.frame.width, height: self.view.frame.height * 0.1) )
        self.temp!.text = "0°"
        self.temp!.textAlignment = .center
        self.temp!.font = self.temp!.font.withSize(CGFloat(35))
        
        self.time = UILabel(frame: CGRect(x: (self.view.frame.maxX-self.view.frame.width) * 0.2, y: (self.view.frame.maxY-self.view.frame.height * 0.1) * 0.65, width: self.view.frame.width, height: self.view.frame.height * 0.1) )
        self.time!.text = "0:0:0"
        self.time!.textAlignment = .center
        self.time!.font = self.time!.font.withSize(CGFloat(35))
        
        self.refresh = UIButton(frame: CGRect(x: (self.view.frame.maxX-self.view.frame.width * 0.3) * 0.5, y: (self.view.frame.maxY-self.view.frame.height * 0.15) * 0.9, width: self.view.frame.width * 0.3, height: self.view.frame.height * 0.15) )
        
        self.option = UIButton(frame: CGRect(x: self.view.frame.maxX*0.75, y: self.view.frame.maxY*0.05, width: self.view.frame.width * 0.3, height: self.view.frame.width * 0.3) )
        self.option?.contentMode = .scaleAspectFit
        
        let config_option = UIImage.SymbolConfiguration(pointSize: CGFloat(30), weight: .bold, scale: .large)
            
        self.refresh!.setImage(UIImage(named: "Refresh"), for: UIControl.State.normal)
        self.option!.setImage(UIImage(systemName: "gearshape", withConfiguration: config_option), for: UIControl.State.normal)
        self.option!.tintColor = .black
        
        self.view.addSubview(self.weather_image!)
        self.view.addSubview(self.city!)
        self.view.addSubview(self.time!)
        self.view.addSubview(self.temp!)
        self.view.addSubview(self.refresh!)
        self.view.addSubview(self.option!)
    
        
        self.refresh?.addTarget(self, action: #selector(reload), for: UIControl.Event.touchUpInside)
        self.option?.addTarget(self, action: #selector(settings), for: UIControl.Event.touchUpInside)
    }
    
    @IBAction func settings(_ sender: UIButton){
        let instance = ViewControllerSettings()
        instance.vc = self
        self.present(instance, animated: true)
    }
    
    @IBAction func reload(_ sender: UIButton){
        self._reload()
    }
    
    func _reload(){
        let ajaccio_data = getGPS()
        guard let main = ajaccio_data["main"] as? [String:NSNumber],  let name = ajaccio_data["name"] as? String, let weather_data = ajaccio_data["weather"] as? Array<[String:Any]> else {
            print("Format change")
            return
        }
        
        //self.temp!.text = String(format:"%.2f°", Double(truncating: main["temp"]!)-273.15)
        self.temp!.text = String(format:"%.2f°", Double(truncating: main["temp"]!))
        self.city!.text = name
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "hh:mm:ss"
        self.time!.text = dateFormat.string(from: NSDate() as Date)
        self.weather_image!.image = UIImage(named: weather_data[0]["main"]! as! String)
    }
    
    func parseJson() -> [String:Any]{
        let path = Bundle.main.path(forResource: "ajaccio", ofType: "json")
        let data:NSData = try! NSData(contentsOfFile: path!)
        /*
        let data:NSData = try! NSData(contentsOf: URL(string:"https://api.openweathermap.org/data/2.5/weather?q=Ajaccio&units=metric&appid=b8c0162f208b810fd4c2e82e370a98a4")!)
        */
        do {
            let ajaccio_data = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as! [String:Any]
            return ajaccio_data
        } catch let error as NSError{
            print(error)
        }
        
        return [:]
    }
    
    func getGPS() -> [String:Any]{
        var lat = ""
        var long = ""
        if(setted_lat != nil && setted_long != nil){
            lat = setted_lat!
            long = setted_long!
        } else {
            lat = String(coordinate.latitude)
            long = String(coordinate.longitude)
        }
        let data:NSData = try! NSData(contentsOf: URL(string:"https://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+long+"&units=metric&appid=b8c0162f208b810fd4c2e82e370a98a4")!)
        do {
            let ajaccio_data = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as! [String:Any]
            return ajaccio_data
        } catch let error as NSError{
            print(error)
        }
        return [:]
    }
    
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]){
        coordinate = locations[0].coordinate
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self._reload()
        }
    }
}

