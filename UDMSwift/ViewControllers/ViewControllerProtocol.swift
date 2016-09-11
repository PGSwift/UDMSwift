//
//  ViewControllerProtocol.swift
//  UDMSwift
//
//  Created by OSXVN on 9/11/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation

protocol ViewControllerProtocol {
    
    static func createInstance() -> UIViewController
    func configItems()
    func initData()
    
}