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
    
    var isLoginSuccess = false
    
    func inforUser() -> RUser! {
        guard let rUser = CacheManager.shareInstance.getRUserList()?.first else {
            fatalError("No found inforUser")
        }
        return rUser
    }
    
    func getListDataUser() -> [String: String?] {

        let user = inforUser()
        
        var data: [String: String?] = [:]
        data["FullName"] = user.fullName
        data["Email"] = user.email
        data["Sex"] = user.sex
        data["BirthDay"] = user.birthday.formatDateFromString(user.birthday)
        data["City"] = user.city
        data["Phone Number"] = user.phoneNumber
        data["Money"] = String(user.money)
        
        return data
    }
    
    func getAvata() -> UIImage? {
        var url = ""
        dispatch_async(dispatch_get_main_queue()) { 
            url = self.inforUser().avatar
        }
        
        if url == "" {
            return UIImage(named: "default_avatar")
        } else {
            guard let image = UIImage(data: NSData(contentsOfURL: NSURL(string: url)!)!) as UIImage? else {
                println("User cannot get avata to url = \(url)")
                return nil
            }
            return image
        }
    }
}

final class UDMHelpers {

    // MARK: - Common func
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
    
    static func currentDate() -> String {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = UDMConfig.formatDate
        let someDateTime = formatter.stringFromDate(NSDate())
        return someDateTime
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
