//
//  CreateNewViewController.swift
//  Groupject
//
//  Created by davy ngoma mbaku on 7/26/20.
//  Copyright © 2020 davyngoma. All rights reserved.
//

import UIKit

class CreateNewViewController: UIViewController {
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var imageViewDoc: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var addActionButton: UIButton!
    @IBOutlet weak var titleValue: UITextField!
    @IBOutlet weak var descriptionValue: UITextView!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var contactPerson: UITextField!
    @IBOutlet weak var announcer: UITextField!
    @IBOutlet weak var timeLimit: UITextField!
    var selectedCategory: Model.categories?
    
    var imagePicker: UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create New Announcement"
        buttonSetUp()
        setTextFieldDelegate()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDoneOnKeyboard()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //perform logic to save or update
        //check if back button tapped
        if self.isMovingFromParent {
            handleData()
        }
    }
    
    func handleData() {
        //case saving only title and image
        if let _titleValue = titleValue.text, !_titleValue.isEmpty,
            let image = imageViewDoc.image, date.text == nil,
             let announcer = announcer.text,  !announcer.isEmpty,
        descriptionValue.text == nil, location.text == nil,
            contactPerson.text == nil, timeLimit.text == nil {
            
        let data = Model.Announcement.init(title: _titleValue, description: nil, date: nil, location: nil, contactPerson: nil, announcer: announcer, timeLimit: nil, category: nil, hours: nil, image: image)
        
            //save object
            Model.sharedInstance.addNew(data: data)
            emptyState()
        } else {
            //get input non null or empty to save
            guard let _titleValue = titleValue.text,
                !_titleValue.isEmpty,
                let _date = date.text,
                !_date.isEmpty,
                let _descriptionValue = descriptionValue.text,
                !_descriptionValue.isEmpty,
                let _location = location.text,
                !_location.isEmpty,
                let _contactPerson = contactPerson.text,
                !_contactPerson.isEmpty,
                let _announcer = announcer.text,
                !_announcer.isEmpty,
                let _timeLimit = timeLimit.text,
                !_timeLimit.isEmpty else {
                    return
            }
            
            //create object
            let data = Model.Announcement.init(title: _titleValue, description: _descriptionValue, date: _date, location: _location, contactPerson: _contactPerson, announcer: _announcer, timeLimit: Double(_timeLimit), category: selectedCategory, hours: nil, image: imageViewDoc.image ?? UIImage())
            
            //save object
            Model.sharedInstance.addNew(data: data)
            emptyState()
        }
    }
    
    @IBAction func segmentController(_ sender: UISegmentedControl) {
        //set categories
        switch sender.selectedSegmentIndex {
        case 0:
            selectedCategory = Model.categories.annoucement
        case 1:
            selectedCategory = Model.categories.essentials
        default: break
        }
    }
    
    @IBAction func cameraAction(_ sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.allowsEditing = false
        //Handle if camera source not available
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            DispatchQueue.main.async {
                self.alertView("No Camera", title: "Cancel")
            }
            return
        }
        imagePicker?.sourceType = .camera
        present(imagePicker ?? UIImagePickerController(), animated: true, completion: nil)
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        
    }
}

extension CreateNewViewController {
    //button UI
    func buttonSetUp() {
        cameraButton.layer.cornerRadius = 5
        cameraButton.layer.borderColor = UIColor.white.cgColor
        cameraButton.layer.borderWidth = 3
        addActionButton.layer.cornerRadius = 5
        addActionButton.layer.borderWidth = 3
        addActionButton.layer.borderColor = UIColor.white.cgColor
    }
}

//MARK: UIImagePickerControllerDelegate Delegate - UINavigationControllerDelegate
extension CreateNewViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate  , UITextFieldDelegate, UITextViewDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Done image capture here
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageViewDoc?.image = image
            dismiss(animated: true, completion: nil)
        }
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    /// Description function for textfields to conform to protocol
    ///
    /// - Parameter: - no param
    func setTextFieldDelegate() {
        titleValue.delegate = self
        date.delegate = self
        descriptionValue.delegate = self
        location.delegate = self
        contactPerson.delegate = self
        announcer.delegate = self
        timeLimit.delegate = self
    }
    
    /// Description function to clean fields
    ///
    /// - Parameter: - no param
    func emptyState() {
        titleValue.text = ""
        date.text = ""
        descriptionValue.text = ""
        location.text = ""
        contactPerson.text = ""
        announcer.text = ""
        timeLimit.text = ""
    }
    
    func resignReponder() {
        titleValue.resignFirstResponder()
        date.resignFirstResponder()
        location.resignFirstResponder()
        contactPerson.resignFirstResponder()
        announcer.resignFirstResponder()
        timeLimit.resignFirstResponder()
    }
    
    //set done button for keybaord
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(CreateNewViewController.dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        descriptionValue.inputAccessoryView = keyboardToolbar
        titleValue.inputAccessoryView = keyboardToolbar
        date.inputAccessoryView = keyboardToolbar
        location.inputAccessoryView = keyboardToolbar
        contactPerson.inputAccessoryView = keyboardToolbar
        announcer.inputAccessoryView = keyboardToolbar
        timeLimit.inputAccessoryView = keyboardToolbar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}

