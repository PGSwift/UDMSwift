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
    @IBOutlet weak var locationErrorLabel: UILabel!
    
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var passworldTextField: UITextField!
    @IBOutlet weak var passworldErrorLabel: UILabel!
    
    @IBOutlet weak var RePassworldTextFeild: UITextField!
    @IBOutlet weak var RePassworldErrorLabel: UILabel!
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var buttonAddMoney: UIButton!
    
    let validator = Validator()
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("EdidAccountSettingViewControllerID") as! EdidAccountSettingViewController
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
         println("Init screen EdidAccountSettingViewController")
        
        // Add RightBarButtonItem
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(clickedBarButtonAction(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        // Config label birthDay, gender
        genderLabel.userInteractionEnabled = true
        genderLabel.tag = TabConfig.PickerView.ListView
        
        birthDayLabel.userInteractionEnabled = true
        birthDayLabel.tag = TabConfig.PickerView.Date
        
        myAvataImage.userInteractionEnabled = true
        myAvataImage.layer.cornerRadius = myAvataImage.frame.width / 2
        myAvataImage.clipsToBounds = true
        
        // Add action for label birthDay, gender, myAvata
        let recognizerGender = UITapGestureRecognizer(target: self, action: #selector(showPickerView(_:)))
        genderLabel.addGestureRecognizer(recognizerGender)
        
        let recognizerBirtDay = UITapGestureRecognizer(target: self, action: #selector(showPickerView(_:)))
        birthDayLabel.addGestureRecognizer(recognizerBirtDay)
        
        let recognizerAvata = UITapGestureRecognizer(target: self, action: #selector(showUIPickerImageView(_:)))
        myAvataImage.addGestureRecognizer(recognizerAvata)
        
        initDataForProfile()
        
        validatorDataInput()
    }
    
    func initDataForProfile() {
        
        guard let user = UDMUser.shareManager.inforUser else {
            fatalError()
        }
        
        if let birthday = user.birthday {
            birthDayLabel.text = birthday
        } else {
            let dateFormat = NSDateFormatter()
            dateFormat.dateFormat = "yyyy/MM/dd"
            birthDayLabel.text = dateFormat.stringFromDate(NSDate())
        }
        
        if let city = user.city {
            locationTextField.text = city
        }
        
        if let fullName = user.fullName {
            nameTextField.text = fullName
        }
        
        if let phoneNumber = user.phoneNumber {
            phoneTextField.text = phoneNumber
        }
        
        if let sex = user.sex {
            genderLabel.text = (sex == "0" ? "Female":"Male")
        }
    }
    
    
    func validatorDataInput() {
        
        validator.styleTransformers(success:{ (validationRule) -> Void in
            println("here")
            // clear error label
            validationRule.errorLabel?.hidden = true
            validationRule.errorLabel?.text = ""
            if let textField = validationRule.field as? UITextField {
                textField.layer.borderColor = UIColor.greenColor().CGColor
                textField.layer.borderWidth = 0.5
                
            }
            }, error:{ (validationError) -> Void in
                println("error")
                validationError.errorLabel?.hidden = false
                validationError.errorLabel?.text = validationError.errorMessage
                if let textField = validationError.field as? UITextField {
                    textField.layer.borderColor = UIColor.redColor().CGColor
                    textField.layer.borderWidth = 1.0
                }
        })
        
        validator.registerField(nameTextField, errorLabel: nameErrorLabel , rules: [RequiredRule(), FullNameRule()])
        validator.registerField(phoneTextField, errorLabel: phoneErrorLabel , rules: [RequiredRule(), PhoneNumberRule()])
        validator.registerField(locationTextField, errorLabel: locationErrorLabel , rules: [RequiredRule(), PhoneNumberRule()])
        validator.registerField(passworldTextField, errorLabel: passworldErrorLabel , rules: [RequiredRule(), PasswordRule()])
        validator.registerField(RePassworldTextFeild, errorLabel: RePassworldErrorLabel , rules: [RequiredRule(), PasswordRule()])
    }
    
    // MARK: - Action RightBarButton
    func clickedBarButtonAction(sender: UIButton) {
        
        validator.validate(self)
        //self.navigationController?.popViewControllerAnimated(true)
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

// MARK: - Validator data input
extension EdidAccountSettingViewController: ValidationDelegate {
    
    func validationSuccessful() {
        println("Validation Success!")
        
        guard let fullName = nameTextField.text else { fatalError() }
        let valueSex =  (genderLabel.text == "Female" ? "0":"1")
        
        let data = ["fullName":fullName,"sex":valueSex]
        
        UDMService.editProfile(WithInfo: data) { withData in
            println("----> \(withData)")
        }
//        let alert = UIAlertController(title: "Success", message: "You are validated!", preferredStyle: UIAlertControllerStyle.Alert)
//        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//        alert.addAction(defaultAction)
//        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    func validationFailed(errors:[(Validatable, ValidationError)]) {
        println("Validation FAILED!")
        
        guard let fullName = nameTextField.text else { fatalError() }
        let data = ["fullName":fullName]
        
        UDMService.editProfile(WithInfo: data) { withData in
            println("----> \(withData)")
        }

    }
}
