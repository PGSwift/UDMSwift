//
//  User.swift
//  UDMSwift
//
//  Created by OSXVN on 8/20/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

public struct User {
    public var data: AnyObject
    
    init(info: AnyObject) {
        self.data = info
    }
    
    var mail: String? {
        get {
            if let email = data["email"] as? String {
              return email
            } else {
                return "vinh@gmail.com"
            }
        }
        
        set {
            mail = newValue
        }
    }
    
    var urlAvata: String? {
        get {
            if let urlImage = data["avatar"] as? String {
                return UDMConfig.APIService.rootDoman + urlImage
            } else {
                return ""
            }
        }
        
        set {
            urlAvata = newValue
        }
    }
    
    var fullName: String? {
        get {
            if let name = data["fullName"] as? String {
                return name
            } else {
                return ""
            }
        }
        
        set {
            fullName = newValue
        }
    }
    
    var money: Int? {
        get {
            if let money = data["money"] as? String {
                return Int(money)
            } else {
                return 0
            }
        }
        
        set {
            money = newValue
        }
    }
    
    var city: String? {
        get {
            if let city = data["city"] as? String {
                return city
            } else {
                return "HCM"
            }
        }
        
        set {
            city = newValue
        }
    }
    
    var phoneNumber: String? {
        get {
            if let phone = data["phoneNumber"] as? String {
                return phone
            } else {
                return "0"
            }
        }
        
        set {
            phoneNumber = newValue
        }
    }
    
    var token: String? {
        get {
            return data["token"] as? String
        }
        
        set {
            token = newValue
        }
    }
    
    var level: String? {
        get {
            if let lvl = data["level"] as? String {
                return lvl
            } else {
                return "0"
            }
        }
        
        set {
            level = newValue
        }
    }
    
    var sex: String? {
        get {
            if let sex = data["sex"] as? String {
                return sex
            } else {
                return "1"
            }
        }
        
        set {
            level = newValue
        }
    }
    
    var birthday: String? {
        get {
            if let stringBirthday = data["birthday"] as? String {
                return UDMHelpers.formatDateFromString(stringBirthday)
            } else {
                return "1999/01/01"
            }
        }
        
        set {
            level = newValue
        }
    }
    
    func getAvata() -> UIImage? {
        
        if urlAvata == "" {
            return UIImage(named: "default_avatar")
        } else {
            guard let image = UIImage(data: NSData(contentsOfURL: NSURL(string: urlAvata!)!)!) as UIImage? else {
                println("User \(mail) cannot get avata to url = \(urlAvata)")
                return nil
            }
            
            return image
        }
    }
}
