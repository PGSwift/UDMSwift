//
//  R5StreamingManager.swift
//  UDMSwift
//
//  Created by OSXVN on 10/6/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation

final class R5StreamingManager {
    // MARK: - Properties
    static let shareInstance = R5StreamingManager()
    
    var ip = "61.28.226.35"
    var port: Int32 = 8554
    var context = "live"
    var buffer_time:Float = 1.0
    var bitrate = 750
    
    var camera_width = 640
    var camera_height = 360
    
    var hostName = "61.28.226.35"
    var streamName1 = "vinh1"
    var streamName2 = "vinh2"
    
    var isDebugView = true
    var onVideo = true
    var onAudio = true
    
    
    init () {
       
    }
}