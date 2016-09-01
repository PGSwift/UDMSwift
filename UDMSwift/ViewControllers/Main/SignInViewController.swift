//
//  SignInViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 8/20/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

final class SignInViewController: UIViewController {
    // MARK: - Properties
    var buttonloginFacebook: FBSDKLoginButton!
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("SignInViewControllerID") as! SignInViewController
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Init Screen SignInViewControler")
        // MARK: - Initialize sign-in Google
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
    }
    
    override func viewWillDisappear(animated: Bool) {
        GIDSignIn.sharedInstance().signOut()
    }
    
    // MARK: - Action button Sign
    @IBAction func signWithFacebook(sender: AnyObject) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logInWithReadPermissions(["email"], fromViewController: self) { (result, error) -> Void in
            if (error == nil){
               let fbloginresult : FBSDKLoginManagerLoginResult = result
                if(fbloginresult.grantedPermissions != nil && fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        }
    }
    @IBAction func signWithGoogle(sender: AnyObject) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func signWithEmail(sender: AnyObject) {
        let signUpViewController = SignUpViewController.createInstance()
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    @IBAction func loginAccount(sender: AnyObject) {
        let signUpViewController = SignUpViewController.createInstance() as! SignUpViewController
        signUpViewController.isPageSignIn = true
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
}
// MARK: - Google Sign
extension SignInViewController:GIDSignInUIDelegate, GIDSignInDelegate {

    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        println("ActivityIndicator")
    }
    
    func signIn(signIn: GIDSignIn!, presentViewController viewController: UIViewController!) {
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    func signIn(signIn: GIDSignIn!, dismissViewController viewController: UIViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil) {
            //get infor send to server
            guard let accessToken = user.authentication.accessToken else {
                //Log
                fatalError()
            }
            let data = ["accessToken": accessToken]
            UDMService.signInUpAccount(WithInfo: data, withCompletion: { (data) in

                _ = data["accessToken"]
                
                self.navigationController?.popViewControllerAnimated(true)
            })
            
            println("Infor user from Google : \(user.profile)")
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        let data = ["fullname":"", "email":"", "password":""]
        UDMService.signInUpAccount(WithInfo: data, withCompletion: { (data) in
            
            _ = data["accessToken"]
            
            self.navigationController?.popViewControllerAnimated(true)
        })
    }
}
// MARK: - Facebook Sign
extension SignInViewController {
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        //println("\(UDMUser.shareManager.getInforUser().fullName) Logged Out")
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    println("Infor user from Facebook : \(result)")
                    let data = ["accessToken": String(result["accessToken"])]
                    UDMService.signInUpAccount(WithInfo: data, withCompletion: { (data) in
                        
                        _ = data["accessToken"]
                        
                        self.navigationController?.popViewControllerAnimated(true)
                    })

                    //everything works print the user data
                    print(result)
                }
            })
        }
    }
}
