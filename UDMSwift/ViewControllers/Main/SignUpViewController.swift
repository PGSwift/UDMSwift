//
//  SignUpViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 8/23/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

class SignUpViewController: UIViewController, ViewControllerProtocol, UITextFieldDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titlePage: UILabel!
    
    @IBOutlet weak var textBoxEmail: UITextField!
    
    @IBOutlet weak var iconFullName: UIImageView!
    @IBOutlet weak var textBoxFullName: UITextField!
    
    @IBOutlet weak var iconPassword: UIImageView!
    @IBOutlet weak var textBoxPassword: UITextField!
    @IBOutlet weak var textBoxRePassword: UITextField!
    
    @IBOutlet weak var line1View: UIView!
    
    @IBOutlet weak var buttonSignUp: UIButton!
    @IBOutlet weak var labelPolicy: UILabel!
    
    var isPageSignIn: Bool = false
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("SignUpViewControllerID") as! SignUpViewController
    }
    
    func configItems() {
        
        //SetUp page SignIn
        iconFullName.hidden = isPageSignIn
        textBoxFullName.hidden = isPageSignIn
        iconPassword.hidden = isPageSignIn
        textBoxRePassword.hidden = isPageSignIn
        line1View.hidden = isPageSignIn
        
        // Delegate textBox
        textBoxFullName.delegate = self
        textBoxEmail.delegate = self
        textBoxPassword.delegate = self
        textBoxRePassword.delegate = self
        
        if isPageSignIn {
            titlePage.text = "Sign in with your email address"
            labelPolicy.text = "By clicking on 'Sign In' you agree to our Terms of Service and Privacy Policy."
        }
    }
    
    func initData() {
        
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Init screen SignUpViewController")
        
        configItems()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // MARK: - Sign Account
    @IBAction func signUpAccount(sender: AnyObject) {

        guard let email = textBoxEmail.text, passwd = textBoxPassword.text else {
            return
        }

        if email == "" || passwd == "" {
            UDMAlert.alert(title: "Error", message: "Do not blank fields", dismissTitle: "Cancel", inViewController: self, withDismissAction: nil)
            return
        }
        
        if isPageSignIn {
            
            if checkError(isPageSignIn) {
                return
            }
            
            let data = UDMInfoDictionaryBuilder.login(withEmail: "admin@gmail.com", password: "123456")
            
            UDMService.signInAccount(withInfo: data, Completion: { (data, success) in
                if success {
                    self.saveUser(withData: data)
                } else {
                    println("ERROR message: \(data["message"]!)")
                }

            })
        } else {
            
            guard let fullName = textBoxFullName.text else {
                return
            }
            
            if checkError(isPageSignIn) {
                return
            }
            
            let data = UDMInfoDictionaryBuilder.signin(withFullName: fullName, email: email, password: passwd)
            
            UDMService.signUpAccount(WithInfo: data, Completion: { (data, success) in
                if success {
                    self.saveUser(withData: data)
                } else {
                     println("ERROR message: \(data["message"]!)")
                }
            })
        }
    }
    
    func saveUser(withData data: [String: AnyObject]) -> Void{
        println("Data--> \(data)")
        UDMUser.shareManager.initInfoUserWith(info: data)
        
        var viewControllers = self.navigationController?.viewControllers
        viewControllers?.removeLast(2)
        self.navigationController?.setViewControllers(viewControllers!, animated: true)
    }
    
    func checkError(flat: Bool) -> Bool {
        //Error check
        var isError = false
        var strError = ""
        
        if !UDMHelpers.isValidEmail(textBoxEmail.text!) {
            strError = "Must be a valid email address"
            isError = true
        }
        
        if !UDMHelpers.checkMinLength(textBoxPassword, minLength: 8) {
            strError += "\nPassword must be >= 8 length"
            isError = true
        }
        
        if UDMHelpers.checkMaxLength(textBoxPassword, maxLength: 16) {
            strError += "\nPassword must be <= 15 length"
            isError = true
        }

        if !flat {
            
            if !UDMHelpers.checkMinLength(textBoxRePassword, minLength: 8) {
                strError += "\nRePassword must be >= 8 length"
                isError = true
            }
            
            if UDMHelpers.checkMaxLength(textBoxRePassword, maxLength: 16) {
                strError += "\nRePassword must be <= 15 length"
                isError = true
            }
            
            if textBoxPassword.text != textBoxRePassword.text {
                strError += "\nRePassword not same!"
                isError = true
            }
            
            if textBoxFullName.text == "" {
                strError += "\nDo not blank fields"
                isError = true
            }
        }
        
        if isError {
            UDMAlert.alert(title: "Error", message: strError, dismissTitle: "Cancel", inViewController: self, withDismissAction: nil)
            return true
        }
        
        return false
    }
}
