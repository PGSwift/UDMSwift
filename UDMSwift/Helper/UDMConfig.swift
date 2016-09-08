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
    
    static let forcedHideActivityIndicatorTimeInterval: NSTimeInterval = 30
//    static let minMessageTextLabelWidth: CGFloat = 20.0
//    
//    static let minMessageSampleViewWidth: CGFloat = 25.0
    
//    static let termsURLString = "http://privacy.soyep.com"
//    static let appURLString = "itms-apps://itunes.apple.com/app/id" + "983891256"
//  MARK: - Setting Struct
//    struct Notification {
//        static let OAuthResult = "YepConfig.Notification.OAuthResult"
//        static let createdFeed = "YepConfig.Notification.createdFeed"
//        static let deletedFeed = "YepConfig.Notification.deletedFeed"
//        static let switchedToOthersFromContactsTab = "YepConfig.Notification.switchedToOthersFromContactsTab"
//        static let blockedFeedsByCreator = "YepConfig.Notification.blockedFeedsByCreator"
//    }
  
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
        static let doman = "http://192.168.1.7/server/api/"
        
        static func urlUpdate(withFunc funcName: String, token: String) -> String{
            return "http://192.168.1.7/server/api/?func=\(funcName)&model=user&token=\(token)"
        }
        
        // MARK: - Function name
        enum FuncName: String {
            case LoginMail = "login_email"
            case RegisterEmail = "register_email"
            case UpdateProfile = "user_update"
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