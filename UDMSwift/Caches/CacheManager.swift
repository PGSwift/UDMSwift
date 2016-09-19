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
            var obj: AnyObject
            
            switch type {
            case .User:
                obj = realm.objects(RUser.self)
                break
            case .Category:
                obj = realm.objects(RCategory.self)
                break
            case .Course:
                obj = realm.objects(RCourse.self)
                break
            }
            
            try realm.write{
                realm.delete(obj as! Object)
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

}

