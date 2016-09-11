//
//  UDMHelpers.swift
//  UDMSwift
//
//  Created by OSXVN on 8/25/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation


// MARK: - Singletons

final class UDMUser: NSObject {
    
    static let shareManager = UDMUser()
    
    var inforUser: User!
    
    func initInfoUserWith(info data: [String: AnyObject]) {
        inforUser = User(info: data["data"]!)
    }
    
    func getListDataUser() -> [String: String?] {
        
        var data: [String: String?] = [:]
        data["FullName"] = inforUser.fullName
        data["Email"] = inforUser.mail
        data["Sex"] = inforUser.sex
        data["BirthDay"] = inforUser.birthday
        data["City"] = inforUser.city
        data["Phone Number"] = inforUser.phoneNumber
        data["Money"] = String(inforUser.money)
        
        return data
    }
}

// MARK: - Social Network
enum SocialNetwork: String {
    case MAIL = "email"
    case GOOGLE = "google"
    case FACEBOOK = "facebook"
}

final class UDMHelpers {
    
    static func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        
        return nil
    }
    
    // MARK: - Validation
    static func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    static func checkMaxLength(textField: UITextField!, maxLength: Int) -> Bool {
        if (textField.text!.characters.count > maxLength) {
            return true
        }
        return false
    }
    
    static func checkMinLength(textField: UITextField!, minLength: Int) -> Bool{
        if (textField.text!.characters.count > minLength) {
            return true
        }
        return false
    }
    
}



//// MARK: - Message receive from Service
//public struct MessageServer {
//    let success: Bool
//    let error: String?
//    let title: String?
//    
//    init(info: [String: AnyObject]) {
//        success = (info["success"] as? Bool) ?? false
//        error = info["error"] as? String
//        title = info["title"] as? String
//    }
//}

