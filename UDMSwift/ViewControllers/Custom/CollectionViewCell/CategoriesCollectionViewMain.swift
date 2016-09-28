//
//  CategoriesCollectionViewMain.swift
//  UDMSwift
//
//  Created by OSXVN on 9/28/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class CategoriesCollectionViewMain: UICollectionViewCell, ReusableView  {
    // MARK: - Properties
    static let ReuseIdentifier: String = "CategoriesCollectionViewMainID"
    static let NibName: String = "CategoriesCollectionViewMain"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameCategory: UILabel!
    
    var categorie: RCategory = RCategory()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.backgroundColor = ChameleonManger.theme()
    }
    
    override func layoutSubviews() {
        self.nameCategory.textAlignment = .Center
        self.nameCategory.backgroundColor = UIColor.clearColor()
        
        self.imageView.addSubview(nameCategory)
        
        let url = categorie.thumbnail
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let img = UDMHelpers.getImageByURL(with: url)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.imageView.image = img
            })
        }
    }

}
