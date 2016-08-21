//
//  Containt.swift
//  UDMSwift
//
//  Created by OSXVN on 8/20/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

// MARK: - UIStoryboard instance
let MainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)



// MARK: - number Tab
enum TabButtonSeeAll: Int {
    case Description = 1, Curriculum, Review, Instructor
}

final class UDMConfig {
    
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
  
    // MARK: - IDCell Default
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