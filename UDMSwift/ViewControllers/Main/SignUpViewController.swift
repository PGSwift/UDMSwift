//
//  SignUpViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 8/23/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

class SignUpViewController: UIViewController, UITextFieldDelegate {
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
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Init screen SignUpViewController")
        
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // MARK: - Sign Account
    @IBAction func signUpAccount(sender: AnyObject) {
        
        var viewControllers = self.navigationController?.viewControllers
        viewControllers?.removeLast(2)
        self.navigationController?.setViewControllers(viewControllers!, animated: true)
        
        return
        
        //check error
        guard let fullName = textBoxFullName.text,  email = textBoxEmail.text, passwd = textBoxPassword.text else {
            fatalError()
        }
        
        if isPageSignIn {
            
            let data = ["model":"user","func": UDMConfig.APIService.FuncName.LoginMail.rawValue, "email":"vinh@gmail.com", "password":"123456"]
            //let data = ["mode":"user","func": UDMConfig.APIService.FuncName.LoginMail.rawValue, "email":email, "password":passwd]
            
            UDMService.signInUpAccount(WithInfo: data, withCompletion: { (data) in
                self.saveUser(withData: data)
            })
        } else {
            
            let data = ["model":"user","func": UDMConfig.APIService.FuncName.RegisterEmail.rawValue, "fullName":fullName, "email":email, "password":passwd]
            UDMService.signInUpAccount(WithInfo: data, withCompletion: { (data) in
                self.saveUser(withData: data)
            })
        }
    }
    
    func saveUser(withData data: [String: AnyObject]) -> Void{
        UDMUser.shareManager.initInfoUserWith(info: data)
        
        var viewControllers = self.navigationController?.viewControllers
        viewControllers?.removeLast(2)
        self.navigationController?.setViewControllers(viewControllers!, animated: true)
    }
}
