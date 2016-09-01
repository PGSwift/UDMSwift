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
    // MARK: - Account
    static func signInUpAccount(WithInfo info: [String: String]?,withCompletion completion: ((withData: [String: AnyObject]) ->Void)?) {
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
                
                if (info!["model"] == UDMConfig.APIService.FuncName.LoginMail.rawValue) {
                    print("Infor login Success: \(NSString(data: response.data!, encoding:NSUTF8StringEncoding))")
                } else {
                    print("Infor Sign Success: \(NSString(data: response.data!, encoding:NSUTF8StringEncoding))")
                }
                
                guard let completion = completion else {
                    println("Not found Clouse Completion")
                    fatalError()
                }
                
                completion(withData: result)
               
                //Log
        }
    }
    
//    static func signInAccountWith(info paramaters: [String: String]?) -> AnyObject? {
//        var result: AnyObject?
//        
//        Alamofire.request(.GET,  UDMConfig.APIService.Account.signIn, parameters: paramaters)
//            .responseJSON { response in
//                if response.result.isSuccess {
//                    result = response.result.value
//                    print(response.request)
//                    //Log
//                } else {
//                    //Log
//                    // show alert
//                    result = nil
//                }
//                print("result = \(NSString(data: response.data!, encoding:NSUTF8StringEncoding))")
//        }
//        
//        return result
//    }
}
