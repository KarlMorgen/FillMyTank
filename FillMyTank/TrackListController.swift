//
//  TrackListController.swift
//  FillMyTank
//
//  Created by user161495 on 1/2/20.
//  Copyright © 2020 MarouenAbdi. All rights reserved.
//

import UIKit

class TrackListController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var textFieldPicker: UITextField!
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     datePicker = UIDatePicker()
    datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(TrackListController.dateChanged(datePicker:)), for: .valueChanged)

        textFieldPicker.inputView = datePicker

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TrackListController.viewTapped(gestureRecogniser:)))
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
    
    @IBAction func takePhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
}
