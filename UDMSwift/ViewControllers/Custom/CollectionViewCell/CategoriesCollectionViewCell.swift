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
    var nameCategory: UILabel!
    
    var rect: CGRect!
    
    var categorie: RCategory = RCategory()
    
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
         nameCategory = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        nameCategory.textColor = UIColor.whiteColor()
        nameCategory.textAlignment = .Center
        nameCategory.backgroundColor = UIColor.clearColor()
        nameCategory.text = categorie.title
        self.myImage.addSubview(nameCategory)
    }
    
    override func layoutSubviews() {
       // super.layoutSubviews()
        //nameCategory = UILabel(frame: CGRectMake(0, 0, self.bounds.width, self.bounds.height))
        nameCategory.frame = rect
        nameCategory.text = categorie.title
        nameCategory.textColor = UIColor.whiteColor()
        nameCategory.textAlignment = .Center
        nameCategory.backgroundColor = UIColor.clearColor()
        
        self.myImage.addSubview(nameCategory)
        
        let url = categorie.thumbnail
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let img = UDMHelpers.getImageByURL(with: url)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.myImage.image = img
            })
        }
    }
}
