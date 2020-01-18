//
//  TrackListController.swift
//  FillMyTank
//
//  Created by user161495 on 1/18/20.
//  Copyright © 2020 MarouenAbdi. All rights reserved.
//

import UIKit

class TrackListController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var TrackList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TrackListController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.kmsLabel?.text = ""
        cell.litersLabel?.text = ""
        cell.dateLabel?.text = ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TrackList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
