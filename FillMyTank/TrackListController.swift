//
//  TrackListController.swift
//  FillMyTank
//
//  Created by user161495 on 1/18/20.
//  Copyright © 2020 MarouenAbdi. All rights reserved.
//

import UIKit
import CoreData

class TrackListController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var TrackList = [TrackItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest: NSFetchRequest<TrackItem> = NSFetchRequest<TrackItem>(entityName: "TrackItem")
        do{
          let TrackList = try PersistenceService.context.fetch(fetchRequest)
            self.TrackList = TrackList
            self.tableView.reloadData()
        }catch{
            
        }
        
    }
}

extension TrackListController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TrackListTableViewCell
        
        
        cell.kmsLabel?.text = String(TrackList[indexPath.row].kms)
        cell.litersLabel?.text = String(TrackList[indexPath.row].liters)
        cell.dateLabel?.text = String(TrackList[indexPath.row].date ?? "NO Date Added")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TrackList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
