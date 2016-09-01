//
//  User.swift
//  UDMSwift
//
//  Created by OSXVN on 8/20/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

public struct User {
    public var data: [String: AnyObject] = [:]
    
    init(info: [String: AnyObject]) {
        self.data = info
    }
    
    var mail: String? {
        get {
            return data["email"] as? String
        }
        set(newValue) {
            mail = newValue
        }
    }
    
    var urlAvata: String? {
        get {
            return data["avata"] as? String
        }
        
        set(newValue) {
            urlAvata = newValue
        }
    }
    
    var fullName: String? {
        get {
            return data["fullName"] as? String
        }
        
        set(newValue) {
            fullName = newValue
        }
    }
    
    var money: Double? {
        get {
            return data["money"] as? Double
        }
        set(newMoney) {
            money = newMoney
        }
    }
    
    var city: String? {
        get {
            return data["city"] as? String
        }
        set(newCity) {
            city = newCity
        }
    }
    
    var phoneNumber: String? {
        get {
            return data["phoneNumber"] as? String
        }
        set(newPhoneNumber) {
            phoneNumber = newPhoneNumber
        }
    }
    
    var token: String? {
        get {
            return data["token"] as? String
        }
        set(newToken) {
            token = newToken
        }
    }
    
    var level: String? {
        get {
            return data["level"] as? String
        }
        set(newLevel) {
            level = newLevel
        }
    }
    
    var sex: String? {
        get {
            return data["sex"] as? String
        }
        set(newSex) {
            level = newSex
        }
    }
    
    var birthday: String? {
        get {
            return data["birthday"] as? String
        }
        set(newBirthday) {
            level = newBirthday
        }
    }
    
    func getAvata() -> UIImage? {
        guard let urlAvata = urlAvata as String? else {
            println("User \(mail) have not avata url")
            return nil
        }
        
        guard let image = UIImage(data: NSData(contentsOfURL: NSURL(string: urlAvata)!)!) as UIImage? else {
        println("User \(mail) cannot get avata to url = \(urlAvata)")
        return nil
        }
        
        return image
    }
}
