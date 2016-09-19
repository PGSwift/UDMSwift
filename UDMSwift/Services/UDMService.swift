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
    
    static let shareInstance = UDMService()
    
    private func executeRequestAPI(with info: [String: String]?, andCompletion completion: ((data: [String: AnyObject], success: Bool) ->Void)?) {
        
        guard let _info = info else {
            println("executeRequestAPI Infomation = nil")
            return
        }
        
        AlamofireManager.shareInstance.requestUrlByPOST(withURL: UDMConfig.APIService.doman, paramater: _info, encode: .URLEncodedInURL, Completion: completion)
    }
    
    private func executeUploadAPI(with info: [String: AnyObject]?, url: String, andCompletion completion: ((data: [String: AnyObject], success: Bool) ->Void)?) {
        
        guard let _info = info else {
            println("executeUploadAPI Infomation = nil")
            return
        }
        
        AlamofireManager.shareInstance.requestUrlByPOST(withURL: url, paramater: _info, Completion: completion)
    }
    
    // MARK: - Account
    func signInAndSignUpAccount(with info: [String: String]?, Completion completion: ((data: [String: AnyObject], success: Bool) ->Void)?) {
        executeRequestAPI(with: info, andCompletion: completion)
    }
    
    func editProfile(with info: [String: String]?, Completion completion: ((data: [String: AnyObject], success: Bool) ->Void)?) {
        
        let urlUpdate = UDMConfig.APIService.urlUpdateBulder(withFunc: UDMConfig.APIService.FuncName.UpdateProfile.rawValue,
                                                             token: UDMUser.shareManager.inforUser().token)
        
        executeUploadAPI(with: info, url: urlUpdate, andCompletion: completion)
    }
    
    func changeAndResetPassword(with info: [String: String]?, Completion completion: ((data: [String: AnyObject], success: Bool) ->Void)?) {
        executeRequestAPI(with: info, andCompletion: completion)
    }
    
    func getListDataFromServer(with info: [String: String]?, Completion completion: ((data: [String: AnyObject], success: Bool) ->Void)?) {
        executeRequestAPI(with: info, andCompletion: completion)
    }
    
}
