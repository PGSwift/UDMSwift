//
//  Containt.swift
//  UDMSwift
//
//  Created by OSXVN on 8/20/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

let screenSize = UIScreen.mainScreen().bounds

// MARK: - UIStoryboard instance
let MainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)

// MARK: - IDCell Default
let idHeaderDefauleCell0 = "idHeaderDefauleCell0"
let idHeaderDefauleCell = "idHeaderDefauleCell"
let idDefauleCell = "idDefauleCell"

// MARK: - number Tab
enum tabButtonSeeAll: Int {
    case Description = 1, Curriculum, Review, Instructor
}

// MARK: - All Notification names
struct GlobalNotifications {
    static let NFReceive = "Receive"
}


