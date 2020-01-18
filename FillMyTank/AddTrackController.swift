//
//  TrackListController.swift
//  FillMyTank
//
//  Created by user161495 on 1/2/20.
//  Copyright © 2020 MarouenAbdi. All rights reserved.
//

import UIKit

class AddTrackController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var ImageData: NSData!
    
    @IBOutlet weak var kmsField: UITextField!
    @IBOutlet weak var litersField: UITextField!
    @IBOutlet weak var ImagePreview: UIImageView!
    @IBOutlet weak var textFieldPicker: UITextField!
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     datePicker = UIDatePicker()
    datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(AddTrackController.dateChanged(datePicker:)), for: .valueChanged)

        textFieldPicker.inputView = datePicker

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddTrackController.viewTapped(gestureRecogniser:)))
        view.addGestureRecognizer(tapGesture)
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
        
        print("I made it to AddTrack§§§§§")
        
        let item = TrackItem(context: PersistenceService.context)
        item.kms = Int32(kmsField!.text!)!
        item.liters = Float(litersField!.text!)!
        item.date = textFieldPicker!.text!
        PersistenceService.saveContext()
    }
    
    
}
