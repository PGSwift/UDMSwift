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
    @IBOutlet weak var chooseImageLabel: UILabel!
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
    
    @IBOutlet weak var passworldTextField: UITextField!
    @IBOutlet weak var passworldErrorLabel: UILabel!
    
    @IBOutlet weak var RePassworldTextFeild: UITextField!
    @IBOutlet weak var RePassworldErrorLabel: UILabel!
    
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var buttonAddMoney: UIButton!
    
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var passwordOldCell: UITableViewCell!
    @IBOutlet weak var passwordNewCell: UITableViewCell!

    let validator = Validator()
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("EdidAccountSettingViewControllerID") as! EdidAccountSettingViewController
    }
    
    func configItems() {
        
        genderLabel.userInteractionEnabled = true
        genderLabel.tag = TabConfig.PickerView.ListView
        
        birthDayLabel.userInteractionEnabled = true
        birthDayLabel.tag = TabConfig.PickerView.Date
        
        chooseImageLabel.userInteractionEnabled = true
        myAvataImage.userInteractionEnabled = true
        myAvataImage.layer.cornerRadius = myAvataImage.frame.width / 2
        myAvataImage.clipsToBounds = true
        
        passwordNewCell.hidden = true
        passwordOldCell.hidden = true
    }

    func initData() {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let img = UDMUser.shareManager.inforUser.getAvata()
            
            dispatch_async(dispatch_get_main_queue(), {
                self.myAvataImage.image = img
            })
        }
        
        guard let user = UDMUser.shareManager.inforUser else {
            fatalError()
        }
        
        if let email = user.mail {
            emailTextFeild.text = email
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
        } else {
            genderLabel.text = "Male"
        }
        
        if let birthday = user.birthday {
            birthDayLabel.text = birthday
        } else {
            birthDayLabel.text = UDMHelpers.currentDate()
        }
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Init screen EdidAccountSettingViewController")
        
        // Add RightBarButtonItem
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(clickedBarButtonAction(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        configItems()
        
        addRecognizer()
        
        initData()
        
        validatorDataInput()
    }
    
    func addRecognizer() {
        
        let recognizerGender = UITapGestureRecognizer(target: self, action: #selector(showPickerView(_:)))
        genderLabel.addGestureRecognizer(recognizerGender)
        
        let recognizerBirtDay = UITapGestureRecognizer(target: self, action: #selector(showPickerView(_:)))
        birthDayLabel.addGestureRecognizer(recognizerBirtDay)
        
        let recognizerAvata = UITapGestureRecognizer(target: self, action: #selector(showUIPickerImageView(_:)))
        myAvataImage.addGestureRecognizer(recognizerAvata)
        
        let recognizerChooseImage = UITapGestureRecognizer(target: self, action: #selector(showUIPickerImageView(_:)))
        chooseImageLabel.addGestureRecognizer(recognizerChooseImage)
        
        //dissmis keyboard
        let recognizerTableView = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        self.tableView.addGestureRecognizer(recognizerTableView)
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
        validator.registerField(locationTextField, errorLabel: locationErrorLabel , rules: [RequiredRule(), MaxLengthRule()])
    }
    
    // MARK: - Action
    func clickedBarButtonAction(sender: UIButton) {
        
        validator.validate(self)
        
//        guard let fullName = nameTextField.text else { return }
//        guard let city = locationTextField.text else { return }
//        guard let phone = phoneTextField.text else { return }
//        guard let birthday = birthDayLabel.text else { return }
//        
//        let valueSex =  genderLabel.text == "Female" ? "0":"1"
//        
//        let data = UDMInfoDictionaryBuilder.updateProfile(withFullName: fullName, phoneNumber: phone, sex: valueSex, birthday: birthday, city: city)
//        
//        UDMService.editProfile(WithInfo: data) { data, success in
//            
//            if success {
//                UDMUser.shareManager.updateInforUser(withInfo: data)
//                
//                println("Update profile success! with data: \(data)")
//            } else {
//                println("Update profile fail! with message: \(data["message"]!)")
//            }
//            
//            self.navigationController?.popViewControllerAnimated(true)
//        }
    }
    
    @IBAction func changeSwich(sender: AnyObject) {
        
        let swich = sender as! UISwitch
        
        passwordNewCell.hidden = !swich.on
        passwordOldCell.hidden = !swich.on
        
        if swich.on {
            validator.registerField(passworldTextField, errorLabel: passworldErrorLabel , rules: [RequiredRule(), PasswordRule()])
            validator.registerField(RePassworldTextFeild, errorLabel: RePassworldErrorLabel , rules: [RequiredRule(), PasswordRule()])
        } else {
            validator.unregisterField(passworldTextField)
            validator.unregisterField(RePassworldTextFeild)
        }
    }
    
    func showPickerView(recognizer: UITapGestureRecognizer) {
        
        hideKeyboard(nil)
        
        let tabNumber = recognizer.view?.tag
        
        if tabNumber == TabConfig.PickerView.Date {
            
            let datePickerView = ActionSheetDatePicker(title: "Date Choose", datePickerMode: UIDatePickerMode.Date, selectedDate: NSDate(),
                                                       doneBlock: { picker, value, index in
                                                        
                                                        let formatter = NSDateFormatter()
                                                        formatter.dateFormat = "yyyy/MM/dd"
                                                        let someDateTime = formatter.stringFromDate(value as! NSDate)
                                                        self.birthDayLabel.text = someDateTime
                                                        
                                                        return },
                                                       cancelBlock: { ActionStringCancelBlock in return },
                                                       origin: recognizer.view?.superview)
            
            let secondsInWeek: NSTimeInterval = 7 * 24 * 60 * 60
            datePickerView.minimumDate = NSDate(timeInterval: -secondsInWeek, sinceDate: NSDate(timeIntervalSince1970: -secondsInWeek))
            datePickerView.maximumDate = NSDate(timeInterval: secondsInWeek, sinceDate: NSDate())
            
            datePickerView.toolbarButtonsColor = ChameleonManger.theme()
            datePickerView.showActionSheetPicker()
        }
        
        if tabNumber == TabConfig.PickerView.ListView {
            
            let indexSelection = genderLabel.text == "Male" ? 0 : 1
            
            let stringPickerView = ActionSheetStringPicker(title: "Gender Choose", rows: ["Male","Female"], initialSelection: indexSelection, doneBlock: { picker, index, value in
                self.genderLabel.text = index == 0 ? "Male" : "Female"
                return
                }, cancelBlock: { ActionSheetStringPicker in return
                }, origin: recognizer.view?.superview)
            
            
            stringPickerView.toolbarButtonsColor = ChameleonManger.theme()
            stringPickerView.showActionSheetPicker()
        }
    }
    
    func showUIPickerImageView(recognizer: UITapGestureRecognizer) {
        
        hideKeyboard(nil)
        
        let optionChooseImageMenu = UIAlertController(title: nil, message: "Option Choose", preferredStyle: .ActionSheet)
        
        let chooseLibrary = UIAlertAction(title: "Choose from Library", style: .Default) { (alert: UIAlertAction!) in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                imagePicker.allowsEditing = false
                self.presentViewController(imagePicker, animated: true, completion: nil)
            } else {
                println("Not found PhotoLibrary")
            }
        }
        
        let chooseCamera = UIAlertAction(title: "Take Photo from Camera", style: .Default) { (alert: UIAlertAction!) in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                imagePicker.allowsEditing = false
                self.presentViewController(imagePicker, animated: true, completion: nil)
            } else {
                println("Not found Camera")
            }
        }
        
        let chooseCancel = UIAlertAction(title: "Cancel", style: .Default) { (alert: UIAlertAction!) in
            optionChooseImageMenu.dismissViewControllerAnimated(true, completion: nil)
        }
        
        optionChooseImageMenu.addAction(chooseLibrary)
        optionChooseImageMenu.addAction(chooseCamera)
        optionChooseImageMenu.addAction(chooseCancel)
        
        self.presentViewController(optionChooseImageMenu, animated: true, completion: nil)
    }
    
    func hideKeyboard(recognizer: UITapGestureRecognizer?) {
        nameTextField.resignFirstResponder()
        addressTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        passworldTextField.resignFirstResponder()
        RePassworldTextFeild.resignFirstResponder()
        locationTextField.resignFirstResponder()
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
        
        guard let fullName = nameTextField.text else { return }
        guard let city = locationTextField.text else { return }
        guard let phone = phoneTextField.text else { return }
        guard let birthday = birthDayLabel.text else { return }
        
        let valueSex =  genderLabel.text == "Female" ? "0":"1"
        
        let data = UDMInfoDictionaryBuilder.updateProfile(withFullName: fullName, phoneNumber: phone, sex: valueSex, birthday: birthday, city: city)
        
        UDMService.editProfile(WithInfo: data) { data, success in
            
            if success {
                UDMUser.shareManager.updateInforUser(withInfo: data)
                
                println("Update profile success! with data: \(data)")
            } else {
                println("Update profile fail! with message: \(data["message"]!)")
            }
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func validationFailed(errors:[(Validatable, ValidationError)]) {
        println("Validation FAILED! : \(errors)")
    }
}
