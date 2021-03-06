//
//  UDMDictionaryBuilder.swift
//  UDMSwift
//
//  Created by OSXVN on 9/8/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation

final class UDMInfoDictionaryBuilder {
    
    static let shareInstance = UDMInfoDictionaryBuilder()
    
    private func builder(withModel model: String?, funcName: String?,token: String?) -> [String: String]{
        
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
        
        return result
    }
    
    // MARK: - Model USER
    
    private func builderUser(withModel model: String?, funcName: String?,token: String?, email: String?, password: String?, currentPassword: String?, newPassword: String?, fullName: String?, sex: String?, phoneNumber: String?, birthday: String?, city: String?) -> [String: String]{
        
        let commonDictionary = builder(withModel: model, funcName: funcName, token: token)
        var result: [String: String] = [:]
        
        if let _email = email {
            result["email"] = _email
        }
        
        if let _password = password {
            result["password"] = _password
        }
        
        if let _currentPassword = currentPassword {
            result["currentPassword"] = _currentPassword
        }
        
        if let _newPassword = newPassword {
            result["newPassword"] = _newPassword
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
        
        if let _birthday = birthday {
            result["birthday"] = _birthday
        }
        
        result.update(commonDictionary)
        
        return result
    }
    
    func login(withEmail email: String, password: String) -> [String: String] {
        
        return builderUser(withModel: UDMConfig.APIService.ModelName.Teacher.rawValue,
                           funcName: UDMConfig.APIService.FuncName.LoginMail.rawValue,
                           token: nil,
                           email: email,
                           password: password, currentPassword: nil, newPassword: nil,
                           fullName: nil, sex: nil, phoneNumber: nil, birthday: nil, city: nil)
    }
    
    func signin(withFullName fullName: String, email: String, password: String) -> [String: String] {
        
        return builderUser(withModel: UDMConfig.APIService.ModelName.Teacher.rawValue,
                           funcName: UDMConfig.APIService.FuncName.RegisterEmail.rawValue,
                           token: nil,
                           email: email,
                           password: password, currentPassword: nil, newPassword: nil,
                           fullName: fullName,
                           sex: nil, phoneNumber: nil, birthday: nil, city: nil)
    }
    
    func updateProfile(withFullName fullName: String, phoneNumber: String, sex: String, birthday: String, city: String) -> [String: String] {
        
        return builderUser(withModel: nil,
                           funcName: nil,
                           token: nil,
                           email: nil, password: nil, currentPassword: nil, newPassword: nil,
                           fullName: fullName,
                           sex: sex,
                           phoneNumber: phoneNumber,
                           birthday: birthday,
                           city: city)
    }
    
    func updatePassword(withOldPassword oldPassworld: String, newPassworld: String) -> [String: String] {
        
        return builderUser(withModel: UDMConfig.APIService.ModelName.Teacher.rawValue,
                           funcName: UDMConfig.APIService.FuncName.ChangePassword.rawValue,
                           token: UDMUser.shareManager.inforUser().token,
                           email: nil,
                           password: nil, currentPassword: oldPassworld, newPassword: newPassworld,
                           fullName: nil, sex: nil, phoneNumber: nil, birthday: nil, city: nil)
    }
    
    func resetPassword(withEmail email: String) -> [String: String] {
        
        return builderUser(withModel: UDMConfig.APIService.ModelName.Teacher.rawValue,
                           funcName: UDMConfig.APIService.FuncName.ResetPassword.rawValue,
                           token:nil,
                           email: email,
                           password: nil, currentPassword: nil, newPassword: nil,
                           fullName: nil, sex: nil, phoneNumber: nil, birthday: nil, city: nil)
    }
    
    // MARK: - Model RUser
    func builderRUser(with data: [String: AnyObject?], password: String?) -> [String: AnyObject]{
        
        let commonDictionary = builderUser(withModel: nil,
                                           funcName: nil,
                                           token: data["token"] as? String,
                                           email: data["email"] as? String,
                                           password: password, currentPassword: nil, newPassword: nil,
                                           fullName: data["fullName"] as? String,
                                           sex: data["sex"] as? String,
                                           phoneNumber: data["phoneNumber"] as? String,
                                           birthday: data["birthday"] as? String,
                                           city: data["city"] as? String)
        
        var result: [String: AnyObject] = [:]
        
        if let _avatar = data["avatar"] as? String{
            result["avatar"] = _avatar
        }
        
        if let _money = data["money"] {
            result["money"] = _money
        }
        
        if let _level = data["level"] {
            result["level"] = _level
        }

        result.update(commonDictionary)
        
        return result
    }
    
    // MARK: - Rating
    func builderRating(withTitle title: String?, description: String?, value: String?) -> [String: String]{
        
        var result: [String: String] = [:]
        
        if let _title = title {
            result["title"] = _title
        }
        
        if let _description = description {
            result["description"] = _description
        }
        
        if let _value = value {
            result["value"] = _value
        }
        
        return result
    }
    
    // MARK: - Model Category
    private func builderCategory(withModel model: String?, funcName: String?,token: String?, idParent: String?) -> [String: String]{
        
        let commonDictionary = builder(withModel: model, funcName: funcName, token: token)
        var result: [String: String] = [:]
        
        if let _idParent = idParent {
            result["parentID"] = _idParent
        }
        
        result.update(commonDictionary)
        
        return result
    }
    
    func getCategoryList(with idParent: String?) -> [String: String] {
        
        return builderCategory(withModel: UDMConfig.APIService.ModelName.Category.rawValue,
                               funcName: UDMConfig.APIService.FuncName.GetData.rawValue,
                               token: UDMUser.shareManager.inforUser().token,
                               idParent: idParent)
    }
    
    // MARK: - Model Course
    private func builderCourse(withModel model: String?, funcName: String?,token: String?, idCategory: String?, courseID: String?, limit: String?, offset: String?) -> [String: String]{
        
        let commonDictionary = builder(withModel: model, funcName: funcName, token: token)
        var result: [String: String] = [:]
        
        if let _idCategory = idCategory {
            result["categoryID"] = _idCategory
        }
        if let _limit = limit {
            result["limit"] = _limit
        }
        if let _offset = offset {
            result["offset"] = _offset
        }
        
        if let _courseID = courseID {
            result["coursesID"] = _courseID
        }
        
        result.update(commonDictionary)
        
        return result
    }
    
    func getCourseList(with idCategory: String?, limit: String, offset: String) -> [String: String] {
        
        return builderCourse(withModel: UDMConfig.APIService.ModelName.Course.rawValue,
                               funcName: UDMConfig.APIService.FuncName.GetData.rawValue,
                               token: UDMUser.shareManager.inforUser().token,
                               idCategory: idCategory, courseID: nil,
                               limit: limit,
                               offset: offset)
    }
    
    func getMyCourseList() -> [String: String] {
        
        return builderCourse(withModel: UDMConfig.APIService.ModelName.Course.rawValue,
                             funcName: UDMConfig.APIService.FuncName.GetMyCourseList.rawValue,
                             token: UDMUser.shareManager.inforUser().token,
                             idCategory: nil, courseID: nil,
                             limit: nil,
                             offset: nil)
    }
    
    func getRateList(withCourseId id: String) -> [String: String] {
        
        return builderCourse(withModel: UDMConfig.APIService.ModelName.Course.rawValue,
                             funcName: UDMConfig.APIService.FuncName.GetRateList.rawValue,
                             token: UDMUser.shareManager.inforUser().token,
                             idCategory: nil, courseID: id,
                             limit: nil,
                             offset: nil)
    }
    
    func getWishList() -> [String: String] {
        
        return builderCourse(withModel: UDMConfig.APIService.ModelName.Course.rawValue,
                             funcName: UDMConfig.APIService.FuncName.GetMyWishList.rawValue,
                             token: UDMUser.shareManager.inforUser().token,
                             idCategory: nil, courseID: nil,
                             limit: nil,
                             offset: nil)
    }
    
    func buyCourses(withCourseId id: String) -> [String: String] {
        
        return builderCourse(withModel: UDMConfig.APIService.ModelName.Course.rawValue,
                             funcName: UDMConfig.APIService.FuncName.BuyCourses.rawValue,
                             token: UDMUser.shareManager.inforUser().token,
                             idCategory: nil, courseID: id,
                             limit: nil,
                             offset: nil)
    }
    
    func addWishList(withCourseId id: String) -> [String: String] {
        
        return builderCourse(withModel: UDMConfig.APIService.ModelName.Course.rawValue,
                             funcName: UDMConfig.APIService.FuncName.AddWishList.rawValue,
                             token: UDMUser.shareManager.inforUser().token,
                             idCategory: nil, courseID: id,
                             limit: nil,
                             offset: nil)
    }
    
    func removeWishList(withCourseId id: String) -> [String: String] {
        
        return builderCourse(withModel: UDMConfig.APIService.ModelName.Course.rawValue,
                             funcName: UDMConfig.APIService.FuncName.RemoveWishList.rawValue,
                             token: UDMUser.shareManager.inforUser().token,
                             idCategory: nil, courseID: id,
                             limit: nil,
                             offset: nil)
    }
    
    func rateCourses(withCourseId id: String) -> [String: String] {
        
        return builderCourse(withModel: UDMConfig.APIService.ModelName.Course.rawValue,
                             funcName: UDMConfig.APIService.FuncName.RateCourses.rawValue,
                             token: UDMUser.shareManager.inforUser().token,
                             idCategory: nil, courseID: id,
                             limit: nil,
                             offset: nil)
    }
    
    func getCourseLiveList() -> [String: String] {
        
        return builderCourse(withModel: UDMConfig.APIService.ModelName.Course.rawValue,
                             funcName: UDMConfig.APIService.FuncName.GetCouseLive.rawValue,
                             token: UDMUser.shareManager.inforUser().token,
                             idCategory: nil, courseID: nil,
                             limit: nil,
                             offset: nil)
    }
    
    func getCoursesDetail(with courseID: String?) -> [String: String] {
        return builderCourse(withModel: UDMConfig.APIService.ModelName.Course.rawValue,
                             funcName: UDMConfig.APIService.FuncName.GetCourseDetail.rawValue,
                             token: UDMUser.shareManager.inforUser().token,
                             idCategory: nil, courseID: courseID,
                             limit: nil,
                             offset: nil)
    }
    
    // MARK: - Model Curriculums
    func getCurriculums(with courseID: String?) -> [String: String] {
        
        return builderCourse(withModel: UDMConfig.APIService.ModelName.Curriculums.rawValue,
                             funcName: UDMConfig.APIService.FuncName.GetData.rawValue,
                             token: UDMUser.shareManager.inforUser().token,
                             idCategory: nil, courseID: courseID,
                             limit: nil,
                             offset: nil)
    }
    
    // MARK: - Model Teacher
    private func builderTeacher(withModel model: String?, funcName: String?,token: String?, teacherID: String?) -> [String: String]{
        
        let commonDictionary = builder(withModel: model, funcName: funcName, token: token)
        var result: [String: String] = [:]
        
        if let _teacherID = teacherID {
            result["teacherID"] = _teacherID
        }
        
        result.update(commonDictionary)
        
        return result
    }
    
    func getTeacherInfo(with teacherID: String?) -> [String: String] {
        
        return builderTeacher(withModel: UDMConfig.APIService.ModelName.Teacher.rawValue,
                             funcName: UDMConfig.APIService.FuncName.GetTeacherInfo.rawValue,
                             token: UDMUser.shareManager.inforUser().token,
                             teacherID: teacherID)
    }
    

}