//
//  LoginService.swift
//  UDMSwift
//
//  Using create request to server,... interdepend to server
//  Created by OSXVN on 8/22/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation
import Alamofire

public struct UDMService {
    
    private static func executeRequestAPI(with info: [String: String]?, andCompletion completion: ((withData: [String: AnyObject]) ->Void)?, notification: ((String) ->Void)?) {
        
        var result: [String: AnyObject] = [:]
        
        Alamofire.request(.POST, UDMConfig.APIService.doman, parameters: info, encoding: .URLEncodedInURL)
            .responseJSON { response in
                print(response.request)
                if response.result.isSuccess {
                    guard let resultQ = convertStringToDictionary(String(data: response.data!, encoding:NSUTF8StringEncoding)!) else {
                        fatalError()
                    }
                    result = resultQ
                } else {
                    result = [:]
                }
                
                guard let completion = completion else {
                    println("Not found clouse completion")
                    fatalError()
                }
                
                completion(withData: result)
                
                notification!((result["status"] as! String))
                
                guard let data = response.data else { fatalError() }
                println("--------------->DATA<---------------- \n \(NSString(data: data, encoding:NSUTF8StringEncoding)!)")
        }
    }
    
    private static func executeUploadAPI(withInfo info: [String: String]?, andURL url: String,andCompletion completion: ((withData: [String: AnyObject]) ->Void)?, notification: ((String) ->Void)?) {
        
        var result: [String: AnyObject] = [:]

        let parameters = [
            "data": [
                "fullName":"VINH CUTE",
                "sex":"0"
            ]
        ]
        
        println("\(parameters)")
        Alamofire.request(.POST, url, parameters: parameters)
            .responseJSON { response in
                print(response.request)
                if response.result.isSuccess {
                    guard let resultQ = convertStringToDictionary(String(data: response.data!, encoding:NSUTF8StringEncoding)!) else {
                        fatalError()
                    }
                    result = resultQ
                } else {
                    result = [:]
                }
                
                guard let completion = completion else {
                    println("Not found clouse completion")
                    fatalError()
                }
                
                completion(withData: result)
                
                guard let notification = notification else {
                    println("Not found clouse notification")
                    fatalError()
                }
                
                guard let status = result["status"] as? String else {
                    notification("FAIL !")
                    return
                }
                notification(status)
                
                guard let data = response.data else { fatalError() }
                println("--------------->DATA<---------------- \n \(NSString(data: data, encoding:NSUTF8StringEncoding)!)")
        }
    }

    
    // MARK: - Account
    static func signInAccount(withInfo info: [String: String]?, Completion completion: ((withData: [String: AnyObject]) ->Void)?) {
        
        guard let info = info as [String: String]? else { fatalError() }
        var data = info
        data["model"] = "user"
        data["func"] = UDMConfig.APIService.FuncName.LoginMail.rawValue
        
        executeRequestAPI(with: data, andCompletion: completion, notification:  { result in
            println("Sign in \(result)!!!")
        })
    }
    
    static func signUpAccount(WithInfo info: [String: String]?, Completion completion: ((withData: [String: AnyObject]) ->Void)?) {
        
        guard let info = info as [String: String]? else { fatalError() }
        var data = info
        data["model"] = "user"
        data["func"] = UDMConfig.APIService.FuncName.RegisterEmail.rawValue
        
        executeRequestAPI(with: data, andCompletion: completion, notification:  { result in
            println("Sign Up \(result)!!!")
        })
    }
    
    static func editProfile(WithInfo info: [String: String]?, Completion completion: ((withData: [String: AnyObject]) ->Void)?) {
        
        //let urlConfig = UDMConfig.APIService.urlUpdate(withFunc: UDMConfig.APIService.FuncName.UpdateProfile.rawValue, token: UDMUser.shareManager.inforUser.token!)
        let urlConfig = "http://192.168.1.7/server/api/?func=user_update&model=user&token=f98a0771cfb419bb6631326c779c8a11"
        
        executeUploadAPI(withInfo: info, andURL: urlConfig, andCompletion: completion, notification:  { result in
            println("Update profile \(result)!!!")
        })
    }
}
