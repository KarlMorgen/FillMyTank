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
    
    
    @IBOutlet weak var ImagePreview: UIImageView!
    @IBOutlet weak var kmsField: UITextField!
    @IBOutlet weak var textFieldPicker: UITextField!
    @IBOutlet weak var litersField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    private var datePicker: UIDatePicker?
    
    var TrackList = [TrackItem]()
    
    func GetData(){
        let fetchRequest: NSFetchRequest<TrackItem> = NSFetchRequest<TrackItem>(entityName: "TrackItem")
        do{
          let TrackList = try PersistenceService.context.fetch(fetchRequest)
            self.TrackList = TrackList
            self.tableView?.reloadData()
        }catch{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetData()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
               datePicker?.addTarget(self, action: #selector(TrackListController.dateChanged(datePicker:)), for: .valueChanged)

        textFieldPicker?.inputView = datePicker!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        textFieldPicker?.text = dateFormatter.string(from: datePicker!.date)

               let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TrackListController.viewTapped(gestureRecogniser:)))
               view.addGestureRecognizer(tapGesture)
        
        kmsField?.placeholder = "Enter your current KM"
        kmsField?.keyboardType = .numberPad
        litersField?.placeholder = "Enter How many liters"
        litersField?.keyboardType = .numberPad
        textFieldPicker?.placeholder = "Click to pick a date"
    }
    
    func viewDidAppear(){
        GetData()
    }
    
    
    @objc func viewTapped (gestureRecogniser: UITapGestureRecognizer){

        view.endEditing(true)

    }

    @objc func dateChanged (datePicker: UIDatePicker){

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        textFieldPicker.text = dateFormatter.string(from: datePicker.date)
        //view.endEditing(true)

    }
    

    
    @IBAction func AddTrack(_ sender: Any) {
        
        let item = TrackItem(context: PersistenceService.context)
        item.kms = Int32(kmsField!.text!)!
        item.liters = Float(litersField!.text!)!
        item.date = textFieldPicker!.text!
        PersistenceService.saveContext()
        //navigationController?.popToRootViewController(animated: true)
        self.performSegue(withIdentifier: "Saved", sender: self)
        self.TrackList.append(item)
        self.tableView?.reloadData()
    }
}

extension TrackListController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TrackListTableViewCell
        
        
        cell.kmsLabel?.text = String(TrackList[indexPath.row].kms) + " Km"
        cell.litersLabel?.text = String(TrackList[indexPath.row].liters) + " L"
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
