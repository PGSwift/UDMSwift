//
//  Containt.swift
//  UDMSwift
//
//  Created by OSXVN on 8/20/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

// MARK: - UIStoryboard instance
let MainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)

// MARK: - Manager TAB number in Views
final class TabConfig {
    
    struct TabButtonSeeAll {
        static let Description = 1
        static let Curriculum = 2
        static let Review = 3
        static let Instructor = 4
    }
    
    struct PickerView {
        static let Date = 101
        static let ListView = 102
    }
}

// MARK: - Config All UDM
final class UDMConfig {
    
    static let AppName = "UDMSwift"
    static let ParentIDRoot = "-1"
    static let CourseIDRoot = "-1"
    
    static let CourseLimit = "10"
    static let CourseOffset = "10"
    
    static let forcedHideActivityIndicatorTimeInterval: NSTimeInterval = 30

   //MARK: - Notification
    struct Notification {
        static let ConnectedInternet = "UDMConfig.Notification.ConnectedInternet"
        static let DisconnetedInternet = "UDMConfig.Notification.DisconnetedInternet"
        static let GetDataCourseAndCategory = "UDMConfig.Notification.GetDataCourseAndCategory"
    }
  static let formatDate = "yyyy/MM/dd"
    
    // MARK: - Default Cell ID
    struct HeaderCellID {
        static let defaulCell0  = "idHeaderDefauleCell0"
        static let defaulCell1  = "idHeaderDefauleCell"
        static let defaulCell   = "idDefauleCell"
    }
    
    //  MARK: - Method ReadOnly
    class func getScreenRect() -> CGRect {
        return UIScreen.mainScreen().bounds
    }
    
    // MARK: - API
    struct APIService {
        
        static let rootDoman = "http://61.28.226.18"
        static let doman = "\(rootDoman)/server/api/"
        
        static func urlUpdateBulder(withFunc funcName: String, token: String) -> String{
            return "\(doman)index.php?func=\(funcName)&model=user&token=\(token)"
        }
        
        // MARK: - Function name
        enum FuncName: String {
            case LoginMail = "login_email"
            case RegisterEmail = "register_email"
            case UpdateProfile = "user_update"
            case ChangePassword = "update_password"
            case ResetPassword = "reset_password"
            case GetData = "get"
            case GetTeacherInfo = "get_teacherInfo"
        }
        
        // MARK: - Function name
        enum ModelName: String {
            case User = "user"
            case Category = "category"
            case Course = "courses"
            case Curriculums = "curriculums"
            case Teacher = "teacher"
        }
        
        struct Account {
            //static let signUp = doman + "?model=user";
            //static let signIn = doman + "login";
        }
    }
}