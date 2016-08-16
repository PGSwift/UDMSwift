//
//  CategoriesCollectionViewCell.swift
//  UDMSwift
//
//  Created by OSXVN on 8/15/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var myImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let width = self.myImage.image!.size.width
        let height = self.myImage.image!.size.height
        let bounds = CGRectMake(0, 0, width, height)
        let markView = UIView(frame: bounds)
        markView.backgroundColor = UIColor.blackColor()
        markView.alpha = 0.5
        
        let yourLabel = UILabel(frame: CGRectMake(0, 0, 100, 100))
        yourLabel.textColor = UIColor.whiteColor()
        yourLabel.textAlignment = .Right
        //yourLabel.sizeToFit()
        yourLabel.backgroundColor = UIColor.clearColor()
        yourLabel.text = "mylabel text"
        
        yourLabel.center = self.myImage.center
        
        self.myImage.addSubview(markView)
        self.myImage.addSubview(yourLabel)
    }
}
