//
//  CategoriesCollectionViewCell.swift
//  UDMSwift
//
//  Created by OSXVN on 8/15/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell , ReusableView {
    // MARK: - Properties
    static let ReuseIdentifier: String = "idCategoriesCollectionViewCell"
    static let NibName: String = "CategoriesCollectionViewCell"
    
    @IBOutlet weak var myImage: UIImageView!
    
    // MARK: - Initialzation
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let width = self.myImage.image!.size.width
        let height = self.myImage.image!.size.height
        let bounds = CGRectMake(0, 0, width, height)
        
        let markView = UIView(frame: bounds)
        markView.backgroundColor = UIColor.blackColor()
        markView.alpha = 0.5
        
        self.myImage.addSubview(markView)
    }
    
    override func layoutSubviews() {
        let nameCategory = UILabel(frame: CGRectMake(0, 0, self.bounds.width, self.bounds.height))
        nameCategory.textColor = UIColor.whiteColor()
        nameCategory.textAlignment = .Center
        nameCategory.backgroundColor = UIColor.clearColor()
        nameCategory.text = "mylabel text"
        self.myImage.addSubview(nameCategory)
    }
}