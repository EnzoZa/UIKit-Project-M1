//
//  ViewController.swift
//  TP4
//
//  Created by Enzo Zampaglione on 14/04/2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var donnees_json:[String:Any] = [:]
    
    var myTableView: UITableView = UITableView()
    var myArray: [[String:Any]]?
    


    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        let path = Bundle.main.path(forResource: "scb_resultats", ofType: "json")
        let data:NSData = try! NSData(contentsOfFile: path!)
        
        do {
            donnees_json = try JSONSerialization.jsonObject(with: data
        as Data, options: .allowFragments) as! [String:AnyObject]
        } catch let error as NSError {
            print(error)
        }
                
        guard let resultats = donnees_json["resultats"] as? [[String:Any]] else {
            print("error guard resultats")
            return
        }
        
        myArray = resultats
        
        myTableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        self.view.addSubview(myTableView)
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(TableCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell : TableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableCell
      
        if self.myArray!.count > 0 {
            cell.setData(myArray: self.myArray!, indexPath: indexPath)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 50.0
    }
    
}

class TableCell: UITableViewCell {
    
    var domLabel: UILabel?
    var scoreLabel: UILabel?
    var extLabel: UILabel?
    var dom_logo_name: UIImageView?
    var ext_logo_name: UIImageView?
    var date: UILabel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.dom_logo_name = UIImageView(frame: CGRect(x: 0, y: 10, width: 56, height: 21))
        self.dom_logo_name?.contentMode = .scaleAspectFit
        
        self.domLabel = UILabel(frame: CGRect(x: 56, y: 10, width: 100, height: 21))
        self.domLabel!.textAlignment = .left
        self.domLabel!.font = UIFont.boldSystemFont(ofSize: 11.0)
        
        self.date = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 10))
        self.date!.textAlignment = .left
        self.date!.font = UIFont.boldSystemFont(ofSize: 8.0)
        
        self.scoreLabel = UILabel(frame: CGRect(x: 156, y: 10, width: 80, height: 21))
        self.scoreLabel!.textAlignment = .center
        self.scoreLabel!.font = UIFont.boldSystemFont(ofSize: 11.0)
        
        self.extLabel = UILabel(frame: CGRect(x: 236, y: 10, width: 100, height: 21))
        self.extLabel!.textAlignment = .right
        self.extLabel!.font = UIFont.boldSystemFont(ofSize: 11.0)
        
        self.ext_logo_name = UIImageView(frame: CGRect(x: 336, y: 10, width: 56, height: 21))
        self.ext_logo_name?.contentMode = .scaleAspectFit
        
        addSubview(domLabel!)
        addSubview(scoreLabel!)
        addSubview(extLabel!)
        addSubview(ext_logo_name!)
        addSubview(dom_logo_name!)
        addSubview(date!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(myArray: [[String:Any]], indexPath: IndexPath) {

        self.domLabel!.text = myArray[indexPath.row]["dom_name"] as? String
        
        if(myArray[indexPath.row]["score"] as! String == ""){
            self.scoreLabel!.text = "-"
        } else {
            self.scoreLabel!.text = myArray[indexPath.row]["score"] as? String
        }
        
        self.extLabel!.text = myArray[indexPath.row]["ext_name"] as? String
        
        self.date!.text = myArray[indexPath.row]["date"] as? String
        
        self.dom_logo_name!.image = UIImage(named:  myArray[indexPath.row]["dom_logo_name"]! as! String)
        
        self.ext_logo_name!.image = UIImage(named:  myArray[indexPath.row]["ext_logo_name"]! as! String)
    }
}
