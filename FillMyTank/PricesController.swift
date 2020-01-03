//
//  PricesController.swift
//  FillMyTank
//
//  Created by user161495 on 12/30/19.
//  Copyright © 2019 MarouenAbdi. All rights reserved.



import UIKit
import FirebaseDatabase

class PricesController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var PricesListTable: UITableView!
    var StationsList = [PricesListModel]()
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listcell = tableView.dequeueReusableCell(withIdentifier: "listcell", for: indexPath) as! PricesListTableViewCell
         
        let  priceItem : PricesListModel
        
        priceItem = StationsList[indexPath.row]
        
        listcell.NameLabel.text = priceItem.Name
        listcell.DieselLabel.text = priceItem.Diesel
        listcell.GasolineLabel.text = priceItem.Gasoline
        listcell.GPLLabel.text = priceItem.GPL
        
        let url = URL(string: priceItem.Image ?? "https://previews.123rf.com/images/mousemd/mousemd1710/mousemd171000009/87405336-404-not-found-concept-glitch-style-vector.jpg")
        do {
        let data = try Data(contentsOf: url!)
            listcell.ImageLabel.image = UIImage(data: data)
            
        }catch {}
        
        
        
        return listcell
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        StationsList.count
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the firebase reference
        
    ref = Database.database().reference().child("Local_Base")
        
        ref.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.StationsList.removeAll()
                
                for prices in snapshot.children.allObjects as! [DataSnapshot]
                {
                    let priceItem = prices.value as? [String: AnyObject]
                    let ItemName = priceItem? ["Name"]
                    let ItemDiesel = priceItem? ["Diesel"]
                    let ItemGasoline = priceItem? ["Gasoline"]
                    let ItemGpl = priceItem? ["GPL"]
                    let ItemImage = priceItem? ["Image"]
                    
                    let price = PricesListModel(Name: ItemName as! String?, Diesel: ItemDiesel  as! String?, Gasoline: ItemGasoline as! String?, GPL: ItemGpl as! String?,
                        Image: ItemImage as! String?)
                
                    self.StationsList.append(price)
                    
                }
                
                self.PricesListTable.reloadData()
            }
            
            
        })
       
    }
    
}
