//
//  ReachabilityManager.swift
//  UDMSwift
//
//  Created by OSXVN on 9/17/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation
import ReachabilitySwift

final class ReachabilityManager {
    
    private var reachability: Reachability?
    
    init () {
        do {
            reachability = try Reachability(hostname: "http://google.com/")
        } catch let error {
            println("Cannot init reachability with error: \(error)")
        }
    }
    
    func startCheckConnectNetwork() {
        
        guard let reachability = reachability else {
            println("Reachability = nil")
            return
        }
        
        reachability.whenReachable = { reachability in
            
            dispatch_async(dispatch_get_main_queue(), {
                
                if reachability.isReachableViaWiFi() {
                    println("Reachable via Wifi")
                } else {
                    println("Reachable via Cellular")
                }
                
                NSNotificationCenter.defaultCenter().postNotificationName(UDMConfig.Notification.ConnectedInternet, object: nil, userInfo:nil)
            })
        }
        
        reachability.whenUnreachable = { reachability in
            dispatch_async(dispatch_get_main_queue(), {
                println("Not reachable")
                NSNotificationCenter.defaultCenter().postNotificationName(UDMConfig.Notification.DisconnetedInternet, object: nil, userInfo: nil)
            })
        }
        
        do {
            try reachability.startNotifier()
        } catch let e {
            println("Cannot start Notifier Reachability NetWork : \(e)")
        }
    }
    
    func stopCheckConnectNetwork() {
        guard let reachability = reachability else {
            println("Reachability = nil")
            return
        }
        
        reachability.stopNotifier()
    }
}


