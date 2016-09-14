//
//  ViewControllerProtocol.swift
//  UDMSwift
//
//  Created by OSXVN on 9/11/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation

@objc protocol ViewControllerProtocol {
    
    static func createInstance() -> UIViewController
    
    optional func configItems()
    optional func initData()
    
    optional func registerNotification()
    optional func deregisterNotification()
    
}