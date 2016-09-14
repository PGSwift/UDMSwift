//
//  Containt.swift
//  UDMSwift
//
//  Created by OSXVN on 8/20/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//


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
    
    static let forcedHideActivityIndicatorTimeInterval: NSTimeInterval = 30

   //MARK: - Notification
    struct Notification {
        static let ConnectedInternet = "UDMConfig.Notification.ConnectedInternet"
        static let DisconnetedInternet = "UDMConfig.Notification.DisconnetedInternet"
    }
  static let formatDate = "yyyy/MM/dd"
    
    // MARK: - Default Cell ID
    struct HeaderCellID {
        static let defaulCell0  = "idHeaderDefauleCell0"
        static let defaulCell1  = "idHeaderDefauleCell"
        static let defaulCell   = "idDefauleCell"
    }
    
//    struct Settings {
//        static let userCellAvatarSize: CGFloat = 80
//        
//        static let introFont: UIFont = {
//            return UIFont.systemFontOfSize(12, weight: UIFontWeightLight)
//        }()
//        
//        static let introInset: CGFloat = 20 + userCellAvatarSize + 20 + 10 + 11 + 20
//    }
    
    //  MARK: - Method ReadOnly
    class func getScreenRect() -> CGRect {
        return UIScreen.mainScreen().bounds
    }
    
//    class func avatarMaxSize() -> CGSize {
//        return CGSize(width: 414, height: 414)
//    }
    
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
            case ChangePassword = "ChangePassword"
        }
        
        // MARK: - Function name
        enum ModelName: String {
            case User = "user"
        }
        
        struct Account {
            //static let signUp = doman + "?model=user";
            //static let signIn = doman + "login";
        }
    }
//    struct ChinaSocialNetwork {
//        
//        struct WeChat {
//            
//            static let appID = "wx10f099f798871364"
//            
//            static let sessionType = "com.Catch-Inc.Yep.WeChat.Session"
//            static let sessionTitle = NSLocalizedString("WeChat Session", comment: "")
//            static let sessionImage = UIImage.yep_wechatSession
//            
//            static let timelineType = "com.Catch-Inc.Yep.WeChat.Timeline"
//            static let timelineTitle = NSLocalizedString("WeChat Timeline", comment: "")
//            static let timelineImage = UIImage.yep_wechatTimeline
//        }
//    }
}