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
    
    private static func executeRequestAPI(withInfo info: [String: String]?, andCompletion completion: ((data: [String: AnyObject], success: Bool) ->Void)?) {
        
        guard let _info = info else {
            println("Infomation = nil")
            return
        }
        
        AlamofireManager.requestUrlByPOST(withURL: UDMConfig.APIService.doman, paramater: _info, encode: .URLEncodedInURL, Completion: completion)
    }
    
    private static func executeUploadAPI(withInfo info: [String: AnyObject]?, url: String, andCompletion completion: ((data: [String: AnyObject], success: Bool) ->Void)?) {
        
        guard let _info = info else {
            println("Infomation = nil")
            return
        }
        
        AlamofireManager.requestUrlByPOST(withURL: url, paramater: _info, Completion: completion)
    }
    
    // MARK: - Account
    static func signInAccount(withInfo info: [String: String]?, Completion completion: ((data: [String: AnyObject], success: Bool) ->Void)?) {
        
        executeRequestAPI(withInfo: info, andCompletion: completion)
    }
    
    static func signUpAccount(WithInfo info: [String: String]?, Completion completion: ((data: [String: AnyObject], success: Bool) ->Void)?) {
 
        executeRequestAPI(withInfo: info, andCompletion: completion)
    }
    
    static func editProfile(WithInfo info: [String: AnyObject]?, Completion completion: ((data: [String: AnyObject], success: Bool) ->Void)?) {

        let urlUpdate = UDMConfig.APIService.urlUpdateBulder(withFunc: UDMConfig.APIService.FuncName.UpdateProfile.rawValue,
                                                             token: UDMUser.shareManager.inforUser.token!)
        
        executeUploadAPI(withInfo: info,url: urlUpdate, andCompletion: completion)
    }
}
