//
//  FirstViewController.swift
//  FillMyTank
//
//  Created by user161495 on 12/27/19.
//  Copyright © 2019 MarouenAbdi. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
     var ref: DatabaseReference!
    
    
    @IBOutlet weak var DailyPricesTable: UITableView!
    var DailyPrices = [DailyPrice]()
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PricesCell
         
        let  price : DailyPrice
        
        price = DailyPrices[indexPath.row]
        
        cell.NameLabel.text = price.Name
        cell.PriceLabel.text = price.Price
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        DailyPrices.count
    }
    
    let backgroundImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        DailyPricesTable.layer.cornerRadius = 10
        DailyPricesTable.tableFooterView = UIView()
        
        
        
        //set the firebase reference
        
    ref = Database.database().reference().child("T_Price")
        
        ref.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.DailyPrices.removeAll()
                
                for prices in snapshot.children.allObjects as! [DataSnapshot]
                {
                    let priceObject = prices.value as? [String: AnyObject]
                    let FuelName = priceObject? ["Name"]
                    let FuelPrice = priceObject? ["Price"]
                    
                    let price = DailyPrice(Name: FuelName as! String?, Price: FuelPrice  as! String?)
                
                    self.DailyPrices.append(price)
                    
                }
                
                self.DailyPricesTable.reloadData()
            }
            
            
        })
       
    }
    

    func setBackground(){
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "53786")
        view.sendSubviewToBack(backgroundImageView)
        
    }
    
   
    
    
    

}

