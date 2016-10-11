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
    
    var port: Int32 = 0
    var context = ""
    var buffer_time:Float = 0.0
    var bitrate = 0
    
    var camera_width = 0
    var camera_height = 0
    
    var hostName = ""
    var streamName1 = "vinh1"
    var streamName2 = "vinh2"
    
    var isDebugView = true
    var onVideo = true
    var onAudio = true
    
    
    init () {
       
    }
}