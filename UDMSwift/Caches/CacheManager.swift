//
//  CacheData.swift
//  UDMSwift
//
//  Created by OSXVN on 9/17/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation
import RealmSwift

final class CacheManager {

    static let shareInstance = CacheManager()
    
    private var realm: Realm?
    
    init() {
        
        realmConfig()
        do {
            realm = try Realm()
            println("Init and configuration Realm")
        } catch let error {
            println("Cannot init Realm with error: \(error)")
        }
    }
    
   private func realmConfig() {
        var config = Realm.Configuration()
        
        // Use the default directory, but replace the filename with the username
        config.fileURL = config.fileURL?.URLByDeletingLastPathComponent?.URLByAppendingPathComponent("\(UDMConfig.AppName).realm")
    
        println("LINK REALM = \(config.fileURL)")
        // Set this as the configuration used for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
    
    // MARK: - Commons
    
    func insert(with data: [String: AnyObject], type: UDMConfig.APIService.ModelName) {
        
        guard let realm = self.realm else {
            println("realm = nil")
            return
        }
        
        do {
            try realm.write{
                switch type {
                case .User:
                    realm.add(RUser(value: data))
                    break
                case .Category:
                    realm.add(RCategory(value: data))
                    break
                case .Course:
                    realm.add(RCourse(value: data))
                    break
                case .Curriculums:
                    realm.add(RCurruculum(value: data))
                    break
                case .Teacher:
                    realm.add(RTeacher(value: data))
                    break
                case .MyCourse:
                    realm.add(RMyCourse(value: data))
                    break
                case .WishList:
                    realm.add(RWishList(value: data))
                    break
                }
            }
        } catch let error {
            println("Cannot cache RUser with error: \(error)")
        }
    }
    
    func updateList(with dataList: [[String: AnyObject]], type: UDMConfig.APIService.ModelName) {
        guard let realm = self.realm else {
            println("realm = nil")
            return
        }
        
        do {
            try realm.write{
                switch type {
                case .User:
                    for data in dataList {
                        realm.add(RCourse(value: data), update: true)
                    }
                    break
                case .Category:
                    for data in dataList {
                        realm.add(RCategory(value: data), update: true)
                    }
                    break
                case .Course:
                    for data in dataList {
                        realm.add(RCourse(value: data), update: true)
                    }
                    break
                case .Curriculums:
                    for data in dataList {
                        realm.add(RCurruculum(value: data), update: true)
                    }
                    break
                case .Teacher:
                    for data in dataList {
                        realm.add(RTeacher(value: data), update: true)
                    }
                    break
                case .MyCourse:
                    for data in dataList {
                        realm.add(RMyCourse(value: data), update: true)
                    }
                    break
                case .WishList:
                    for data in dataList {
                        realm.add(RWishList(value: data), update: true)
                    }
                    break
                }
            }
        } catch let error {
            println("Cannot update cache RUser with error: \(error)")
        }
    }

    func update(with data: [String: AnyObject], type: UDMConfig.APIService.ModelName) {
        guard let realm = self.realm else {
            println("realm = nil")
            return
        }
        
        do {
            try realm.write{
                switch type {
                case .User:
                    realm.add(RUser(value: data), update: true)
                    break
                case .Category:
                    realm.add(RCategory(value: data), update: true)
                    break
                case .Course:
                    realm.add(RCourse(value: data), update: true)
                    break
                case .Curriculums:
                    realm.add(RCurruculum(value: data), update: true)
                    break
                case .Teacher:
                    realm.add(RTeacher(value: data), update: true)
                    break
                case .MyCourse:
                    realm.add(RMyCourse(value: data), update: true)
                    break
                case .WishList:
                    realm.add(RWishList(value: data), update: true)
                    break
                }
            }
        } catch let error {
            println("Cannot update cache RUser with error: \(error)")
        }
    }
    
    func clean(with type: UDMConfig.APIService.ModelName) {
        guard let realm = self.realm else {
            println("realm = nil")
            return
        }
        
        do {
            switch type {
            case .User:
                let obj = realm.objects(RUser.self)
                try realm.write{
                    realm.delete(obj)
                }
                break
            case .Category:
                let obj = realm.objects(RCategory.self)
                try realm.write{
                    realm.delete(obj)
                }
                break
            case .Course:
                let obj = realm.objects(RCourse.self)
                try realm.write{
                    realm.delete(obj)
                }
                break
            case .Curriculums:
                 let obj = realm.objects(RCurruculum.self)
                 try realm.write{
                    realm.delete(obj)
                 }
                break
            case .Teacher:
                let obj = realm.objects(RTeacher.self)
                try realm.write{
                    realm.delete(obj)
                }
                break
            case .MyCourse:
                let obj = realm.objects(RMyCourse.self)
                try realm.write{
                    realm.delete(obj)
                }
                break
            case .WishList:
                let obj = realm.objects(RWishList.self)
                try realm.write{
                    realm.delete(obj)
                }
                break
            }
        } catch let error {
            println("Cannot clean all cache with error: \(error)")
        }
    }
    
    func cleanAll() {
        guard let realm = self.realm else {
            println("realm = nil")
            return
        }
        
        do {
            try realm.write{
                realm.deleteAll()
            }
        } catch let error {
            println("Cannot clean all cache with error: \(error)")
        }
    }
    
    // MARK: - Model RUser
    
    func getRUserList() -> Results<RUser>? {
        
        guard let realm = self.realm else {
            println("realm = nil")
            return nil
        }
        
        return realm.objects(RUser.self)
    }
    
    func updatePassword(with passwordNew: String) {
        guard let realm = self.realm else {
            println("realm = nil")
            return
        }
        
        let ruser = realm.objects(RUser.self)
        do {
            try realm.write{
                ruser.first?.setValue(passwordNew, forKeyPath: "password")
            }
        } catch let error {
            println("Cannot clean all cache with error: \(error)")
        }
    }
    
    // MARK: - Model RCategory
    
    func getRCategoryList() -> [RCategory]? {
        
        guard let realm = self.realm else {
            println("realm = nil")
            return nil
        }

        return realm.objects(RCategory.self).toArray(RCategory.self)
    }
    // MARK: - Model RCourse
    
    func getRCourseList() ->[RCourse]? {
        
        guard let realm = self.realm else {
            println("realm = nil")
            return nil
        }
        
        return realm.objects(RCourse.self).toArray(RCourse.self)
    }
    
    // MARK: - Model RMyCourse
    
    func getRMyCourseList() ->[RMyCourse]? {
        
        guard let realm = self.realm else {
            println("realm = nil")
            return nil
        }
        
        return realm.objects(RMyCourse.self).toArray(RMyCourse.self)
    }
    
    // MARK: - Model RWishList
    
    func getRWishList() ->[RWishList]? {
        
        guard let realm = self.realm else {
            println("realm = nil")
            return nil
        }
        
        return realm.objects(RWishList.self).toArray(RWishList.self)
    }
    
    // MARK: - Model RCurriculum
    
    func getRCurriculmList() ->[RCurruculum]? {
        
        guard let realm = self.realm else {
            println("realm = nil")
            return nil
        }
        
        return realm.objects(RCurruculum.self).toArray(RCurruculum.self)
    }
    
    // MARK: - Model RTeacher
    
    func getRTeacherList() -> Results<RTeacher>? {
        
        guard let realm = self.realm else {
            println("realm = nil")
            return nil
        }
        
        return realm.objects(RTeacher.self)
    }
    
}

