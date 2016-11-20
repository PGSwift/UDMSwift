//
//  CoursesCollectionViewCell.swift
//  UDMSwift
//
//  Created by OSXVN on 8/15/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit
import Cosmos

class CoursesCollectionViewCell: UICollectionViewCell, ReusableView {
    // MARK: - Properties
    static let ReuseIdentifier: String = "idCoursesCollectionViewCell"
    static let NibName: String = "CoursesCollectionViewCell"
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var nameTeacher: UILabel!
    @IBOutlet weak var oldPrice: UILabel!
    @IBOutlet weak var newPrice: UILabel!
    @IBOutlet weak var ratingController: CosmosView!

    var course: RCourse = RCourse()
    
    @IBOutlet weak var courseImage: UIImageView!
    
    // MARK: - Initialzation
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10.0
        
        self.layer.shadowOffset = CGSizeZero
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.grayColor().CGColor
        
        self.layer.masksToBounds = false
        
        self.newPrice.textColor = ChameleonManger.textTheme()
        self.backgroundColor = ChameleonManger.backgroudTheme()
        
//        blueView.layer.shadowColor = UIColor.blackColor().CGColor
//        blueView.layer.shadowOffset = CGSize(width: 3, height: 3)
//        blueView.layer.shadowOpacity = 0.7
//        blueView.layer.shadowRadius = 4.0
        //http://stackoverflow.com/questions/4754392/uiview-with-rounded-corners-and-drop-shadow/34984063#34984063
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initData()
    }
    
    func initData() {
        self.title.text = course.title
        self.nameTeacher.text = course.author
        self.newPrice.text = course.newPrice
        self.oldPrice.text = course.oldPrice
        self.ratingController.userInteractionEnabled = false
        self.ratingController.rating = Double(course.review) ?? 3.5
        
        let url = self.course.thumbnail
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let img = UDMHelpers.getImageByURL(with: url)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.courseImage.image = img
            })
        }
    }

}
