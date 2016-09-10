//
//  UDMDictionaryBuilder.swift
//  UDMSwift
//
//  Created by OSXVN on 9/8/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation

final class UDMInfoDictionaryBuilder {
    
    private static func builder(withModel model: String?, funcName: String?,token: String?, email: String?, password: String?, fullName: String?, sex: String?, phoneNumber: String?, city: String?) -> [String: String]{
        
        var result: [String: String] = [:]
        
        //Common paramater
        if let _model = model {
            result["model"] = _model
        }
        
        if let _funcName = funcName {
            result["func"] = _funcName
        }
        
        if let _token = token {
            result["token"] = _token
        }
        
        //owner paramater
        if let _email = email {
            result["email"] = _email
        }
        
        if let _password = password {
            result["password"] = _password
        }
        
        if let _fullName = fullName {
            result["fullName"] = _fullName
        }
        
        if let _sex = sex {
            result["sex"] = _sex
        }
        
        if let _phoneNumber = phoneNumber {
            result["phoneNumber"] = _phoneNumber
        }
        
        if let _city = city {
            result["city"] = _city
        }
        
        return result
    }
    
    static func login(withEmail email: String, password: String) -> [String: String] {
    
        return builder(withModel: UDMConfig.APIService.ModelName.User.rawValue,
                             funcName: UDMConfig.APIService.FuncName.LoginMail.rawValue,
                             token: nil,
                             email: email,
                             password: password,
                             fullName: nil, sex: nil, phoneNumber: nil, city: nil)
    }
    
    static func signin(withFullName fullName: String, email: String, password: String) -> [String: String] {
        
        return builder(withModel: UDMConfig.APIService.ModelName.User.rawValue,
                              funcName: UDMConfig.APIService.FuncName.RegisterEmail.rawValue,
                              token: nil,
                              email: email,
                              password: password,
                              fullName: fullName,
                              sex: nil, phoneNumber: nil, city: nil)
    }
    
    static func updateProfile(withFullName fullName: String, phoneNumber: String, sex: String, city: String) -> [String: AnyObject] {
        
        return ["data": builder(withModel: nil,
                       funcName: nil,
                       token: nil,
                       email: nil, password: nil,
                       fullName: fullName,
                       sex: sex,
                       phoneNumber: phoneNumber,
                       city: city)]
    }
    
    static func updatePassword(WithOldPassword oldPassworld: String, newPassworld: String) -> [String: String] {
        
        return builder(withModel: UDMConfig.APIService.ModelName.User.rawValue,
                       funcName: UDMConfig.APIService.FuncName.ChangePassword.rawValue,
                       token: UDMUser.shareManager.inforUser.token,
                       email: nil,
                       password: oldPassworld,
                       fullName: nil, sex: nil, phoneNumber: nil, city: nil)
    }
    
    
}