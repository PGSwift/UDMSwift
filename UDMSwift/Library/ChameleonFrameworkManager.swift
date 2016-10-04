//
//  ChameleonFrameworkManager.swift
//  UDMSwift
//
//  Created by OSXVN on 9/10/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation
import ChameleonFramework

final class ChameleonManger {
    
    // MARK: - Set Theme App
    static func setUpTheme() {
        Chameleon.setGlobalThemeUsingPrimaryColor(FlatMint(), withSecondaryColor: theme(), andContentStyle: UIContentStyle.Contrast)
    }
    
    static func theme() -> UIColor {
        return FlatGreen()
    }
    
    static func tintTheme() -> UIColor {
        return FlatGreen()
    }
    
    static func textTheme() -> UIColor {
        return FlatGreen()
    }
    
    static func toolBarTheme() -> UIColor {
        return FlatGreen()
    }
    
    static func backgroudTheme() -> UIColor {
        return FlatWhite()
    }
    
    static func grayTheme() -> UIColor {
        return FlatGray()
    }
}