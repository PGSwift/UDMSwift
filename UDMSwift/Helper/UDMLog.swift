//
//  UDMLog.swift
//  UDMSwift
//
//  Created by OSXVN on 8/25/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation

func println(@autoclosure item: () -> Any) {
    #if DEBUG
        Swift.print(item())
    #endif
}
