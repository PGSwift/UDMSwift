//
//  ModelManager.swift
//  UDMSwift
//
//  Created by OSXVN on 9/17/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - USER
public class RUser: Object {
    public dynamic var fullName = ""
    public dynamic var sex = "0"
    public dynamic var email = ""
    public dynamic var password = ""
    public dynamic var birthday = ""
    public dynamic var city = ""
    public dynamic var phoneNumber = ""
    public dynamic var token = ""
    public dynamic var level = 0
    public dynamic var money = 0
    public dynamic var avatar = ""
    
    override public class func primaryKey() -> String? {
        return "email"
    }
}

// MARK: - CATEGORY
public class RCategory: Object {
    public dynamic var id = "0"
    public dynamic var parentID = "0"
    public dynamic var title = ""
    public dynamic var thumbnail = ""
    
    override public class func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - COURSE
public class RCourse: Object {
    public dynamic var id = "0"
    public dynamic var title = ""
    public dynamic var author = ""
    public dynamic var authorID = ""
    public dynamic var descriptions = ""
    public dynamic var oldPrice = "0"
    public dynamic var newPrice = "0"
    public dynamic var thumbnail = ""
    public dynamic var sale = "0"
    public dynamic var rank = "0"
    public dynamic var review = ""
    public dynamic var student = "0"
    
    override public class func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - CURRICULUMS
public class RCurruculum: Object {
    public dynamic var id = "0"
    public dynamic var ccourseID = ""
    public dynamic var numbers = "0"
    public dynamic var title = ""
    public dynamic var type = "0"
    public dynamic var timeVideo = ""
    public dynamic var videoReview = ""
    public dynamic var videoPlay = ""
    
    override public class func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - TEACHER
public class RTeacher: Object {
    public dynamic var id = "0"
    public dynamic var fullName = ""
    public dynamic var avatar = "0"
    public dynamic var descriptions = ""
    public dynamic var rank = "0"
    
    override public class func primaryKey() -> String? {
        return "id"
    }
}


