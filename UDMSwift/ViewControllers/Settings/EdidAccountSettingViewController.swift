//
//  EdidAccountSettingViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 9/1/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//
import ActionSheetPicker_3_0


class EdidAccountSettingViewController: UITableViewController {

    // MARK: - Properties
    @IBOutlet weak var myAvataImage: UIImageView!
    @IBOutlet weak var intructionTextView: UITextView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameErrorLabel: UILabel!
    
    @IBOutlet weak var birthDayLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var addressErrorLabel: UILabel!
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var phoneErrorLabel: UILabel!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var passworldTextField: UITextField!
    @IBOutlet weak var passworldErrorLabel: UILabel!
    
    @IBOutlet weak var RePassworldTextFeild: UITextField!
    @IBOutlet weak var RePassworldErrorLabel: UILabel!
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var buttonAddMoney: UIButton!
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("EdidAccountSettingViewControllerID") as! EdidAccountSettingViewController
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add RightBarButtonItem
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(clickedBarButtonAction(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        // Config label birthDay, gender
        genderLabel.userInteractionEnabled = true
        genderLabel.tag = TabConfig.PickerView.ListView
        
        birthDayLabel.userInteractionEnabled = true
        birthDayLabel.tag = TabConfig.PickerView.Date
        
        myAvataImage.userInteractionEnabled = true
        
        // Add action for label birthDay, gender, myAvata
        let recognizerGender = UITapGestureRecognizer(target: self, action: #selector(showPickerView(_:)))
        genderLabel.addGestureRecognizer(recognizerGender)
        
        let recognizerBirtDay = UITapGestureRecognizer(target: self, action: #selector(showPickerView(_:)))
        birthDayLabel.addGestureRecognizer(recognizerBirtDay)
        
        let recognizerAvata = UITapGestureRecognizer(target: self, action: #selector(showUIPickerImageView(_:)))
        myAvataImage.addGestureRecognizer(recognizerAvata)
    }
    
    // MARK: - Action RightBarButton
    func clickedBarButtonAction(sender: UIButton) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    // MARK: - acction of label birthDay, gender, myAvata
    func showPickerView(recognizer: UITapGestureRecognizer) {
        let tabNumber = recognizer.view?.tag
        
        if tabNumber == TabConfig.PickerView.Date {
            
            let datePickerView = ActionSheetDatePicker(title: "Date", datePickerMode: UIDatePickerMode.Date, selectedDate: NSDate(),
                                                       doneBlock: { picker, value, index in

                                                        let formatter = NSDateFormatter()
                                                        formatter.dateFormat = "yyyy/MM/dd"
                                                        let someDateTime = formatter.stringFromDate(value as! NSDate)
                                                        self.birthDayLabel.text = someDateTime
                                                        
                                                        return },
                                                       cancelBlock: { ActionStringCancelBlock in return },
                                                       origin: recognizer.view?.superview)
            
            let secondsInWeek: NSTimeInterval = 7 * 24 * 60 * 60
            datePickerView.minimumDate = NSDate(timeInterval: -secondsInWeek, sinceDate: NSDate())
            datePickerView.maximumDate = NSDate(timeInterval: secondsInWeek, sinceDate: NSDate())
            
            datePickerView.showActionSheetPicker()
        }
        
        if tabNumber == TabConfig.PickerView.ListView {
            ActionSheetStringPicker.showPickerWithTitle("Gender Choose", rows: ["Male", "Female"], initialSelection: 1,
                                                        doneBlock: { picker, value, index in
                                                            
                                                            self.genderLabel.text = String(index)
                                                            
                                                            return
                                                            },
                                                        cancelBlock: { ActionStringCancelBlock in return },
                                                        origin: recognizer.view?.superview)
        }
    }
    
    func showUIPickerImageView(recognizer: UITapGestureRecognizer) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
//            imagePicker.allowsEditing = false
//            self.presentViewController(imagePicker, animated: true, completion: nil)
//        }
    }
}

// MARK: - UIImagePickerView Delegate
extension EdidAccountSettingViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        let selectImage: UIImage = image
        myAvataImage.image = selectImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
