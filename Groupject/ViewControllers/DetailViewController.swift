//
//  DetialViewController.swift
//  Groupject
//
//  Created by davy ngoma mbaku on 7/19/20.
//  Copyright © 2020 davyngoma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var timeLimit: UILabel!
    @IBOutlet weak var field1: UITextView!
    @IBOutlet weak var filed2: UITextField!
    @IBOutlet weak var filed3: UITextField!
    @IBOutlet weak var filed5: UITextField!
    @IBOutlet weak var filed4: UITextField!
    @IBOutlet weak var logo: UIImageView!
    
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    
    var descriptionValue: String?
    var date: String?
    var hours: String?
    var location: String?
    var contactPerson: String?
    var timeLimitValue: Double?
    
    var fields = [UITextField]()
    var instance: Model.Announcement?
    var origin = Origin.none
    
    //check the state of Editing
    var isEditingFiled: Bool? {
        didSet {
            if isEditingFiled == true {
                textFieldEditing(isEditingFiled)
            }
            
            if isEditingFiled == false {
                textFieldEditing(isEditingFiled)
            }
        }
    }
    var index: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        //set the array of textfield
        fields = [filed2, filed3, filed4, filed5]
        //loop to conform to delegate
        fields.forEach {
            $0.delegate = self
        }
        field1.delegate = self
        buttonSetUp()
    }
    
    //button UI
    func buttonSetUp() {
        copyButton.layer.cornerRadius = 5
        copyButton.layer.borderColor = UIColor.white.cgColor
        copyButton.layer.borderWidth = 3
        editButton.layer.cornerRadius = 5
        editButton.layer.borderWidth = 3
        editButton.layer.borderColor = UIColor.white.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isEditingFiled = false
        textFieldEditing(isEditingFiled)
        displayData()
        
        switch origin {
        case .today:
            editButton.isHidden = true
        case .tool:
            editButton.isHidden = false
        default: break
        }
        
        if isTimerRunning == false {
            runTimer()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //handle modifying record
        if isEditingFiled == true {
            if let index = index?.index {
                let data = Model.Announcement.init(title: nil, description: field1.text, date: filed2.text, location: filed4.text, contactPerson: filed5.text, announcer: nil, timeLimit: nil, category: nil, hours: filed3.text, image:nil)
                //save object
                Model.sharedInstance.overrideValue(data, index: index)
            }
        }
        
        timer.invalidate()
        seconds = 60    //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
        timeLimit.text = "\(seconds)"
        isTimerRunning = false
    }
    
    func textFieldEditing(_ value: Bool?) {
        if let state = value {
            fields.forEach {
                $0.isEnabled = state
            }
            field1.isEditable = state
        }
    }
    
    func resignResponder() {
        fields.forEach {
            $0.resignFirstResponder()
        }
    }
    
    //display data
    func displayData() {
        timeLimit.text = "\(index?.timeLimit ?? 0)"
        field1.text = index?.field1
        filed2.text = index?.filed2
        filed3.text = index?.filed3
        filed5.text = index?.filed4
        filed4.text = index?.filed5
     }
    
    @IBAction func edit(_ sender: UIButton) {
        isEditingFiled = true
    }
    
    @IBAction func copyTodate(_ sender: UIButton) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}

extension DetailViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
          date = textField.text ?? ""
        case 2:
           hours = textField.text ?? ""
        case 3:
           location = textField.text ?? ""
        case 4:
            contactPerson = textField.text ?? ""
        default: break
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let value = textView.text, !value.isEmpty else {
            return
        }
        descriptionValue = value
    }
}

// MARK: Handle timer
extension DetailViewController {
    func runTimer() {
        //first set the appropriate number of seconds according to the object
        seconds = Int((index!.timeLimit ?? 0) * 60) //get the number of seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(DetailViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            timeLimit.textColor = .red
            DispatchQueue.main.async {
                self.alertView("Time is Up", title: "Cancel")
            }
        } else {
            seconds -= 1     //decrement(count down)the seconds
            timeLimit.text = timeString(time: TimeInterval(seconds)) //update the label
        }
    }
   
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    /// Description function to show alert
    ///
    /// - Parameter: - no param
    func alertView(_ message: String, title: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: title, style: .default, handler: { (alert: UIAlertAction!) in
        })
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
