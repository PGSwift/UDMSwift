//
//  SignInViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 8/20/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var loginFacebook: FBSDKLoginButton!
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("DetailListViewControllerID") as! SignInViewController
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Initialize sign-in Google
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        
        // MARK: - Initialize sign-in Facebook
        if FBSDKAccessToken.currentAccessToken() != nil {
            loginFacebook.readPermissions = ["public_profile", "email"]
            loginFacebook.delegate = self
            self.returnUserData()
        } else {
            loginFacebook.readPermissions = ["public_profile", "email"]
            loginFacebook.delegate = self
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        GIDSignIn.sharedInstance().signOut()
    }
    // MARK: - Action button Sign
    @IBAction func LoginAccount(sender: AnyObject) {
        
    }

    @IBAction func signWithEmail(sender: AnyObject) {
        
    }
}
// MARK: - Google Sign
extension SignInViewController:GIDSignInUIDelegate, GIDSignInDelegate {
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        print("ActivityIndicator")
    }
    
    func signIn(signIn: GIDSignIn!, presentViewController viewController: UIViewController!) {
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    func signIn(signIn: GIDSignIn!, dismissViewController viewController: UIViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil) {
            print("Infor user xxx: \(user.profile)")
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
    }
}
// MARK: - Facebook Sign
extension SignInViewController: FBSDKLoginButtonDelegate {
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if ((error) != nil) {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            if result.grantedPermissions.contains("email") {
                // Do work
            }
            self.returnUserData()
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                print("User Email is: \(userEmail)")
            }
        })
    }
}
