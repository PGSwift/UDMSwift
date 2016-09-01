//
//  Account.swift
//  UDMSwift
//
//  Created by OSXVN on 8/26/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation

public protocol Account {
    var accessToken: String? { get }
    var mail: String? { get }
    var password: String? { get }
    var fullName: String? { get }
    var birthday: String? { get }
    var address: String? { get }
    var avata: UIImage? { get }
}
