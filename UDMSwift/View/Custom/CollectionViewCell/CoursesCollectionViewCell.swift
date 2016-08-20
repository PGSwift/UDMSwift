//
//  CoursesCollectionViewCell.swift
//  UDMSwift
//
//  Created by OSXVN on 8/15/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class CoursesCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10.0
        
        self.layer.shadowOffset = CGSizeZero
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.blackColor().CGColor
        
        self.layer.masksToBounds = false
        
        self.backgroundColor = FlatUIColors.emeraldColor()
        
//        blueView.layer.shadowColor = UIColor.blackColor().CGColor
//        blueView.layer.shadowOffset = CGSize(width: 3, height: 3)
//        blueView.layer.shadowOpacity = 0.7
//        blueView.layer.shadowRadius = 4.0
        //http://stackoverflow.com/questions/4754392/uiview-with-rounded-corners-and-drop-shadow/34984063#34984063
    }

}
