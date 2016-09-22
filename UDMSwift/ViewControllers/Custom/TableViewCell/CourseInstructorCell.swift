//
//  CourseInstructorCell.swift
//  UDMSwift
//
//  Created by OSXVN on 8/18/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

final class CourseInstructorCell: UITableViewCell, ReusableView {
    // MARK: - Properties
    static let ReuseIdentifier: String = "idCourseInstructorCell"
    static let NibName: String = "CourseInstructorCell"
    
    @IBOutlet weak var titleInstructor: UILabel!
    @IBOutlet weak var avataIntructor: UIImageView!
    @IBOutlet weak var nameIntructor: UILabel!
    @IBOutlet weak var detailIntructor: UILabel!
    @IBOutlet weak var addressIntructor: UILabel!
    @IBOutlet weak var textViewContent: UITextView!
    @IBOutlet weak var buttonSeeAll: UIButton!
    
    var teacher = RTeacher()
    
    // MARK: - Method
    override func awakeFromNib() {
        super.awakeFromNib()
        textViewContent.sizeToFit()
        textViewContent.scrollEnabled = false
        
    }
    
    override func layoutSubviews() {
        nameIntructor.text = teacher.fullName
        textViewContent.text = teacher.descriptions
        
        let url = teacher.avatar
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let img = UDMHelpers.getImageByURL(with: url)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.avataIntructor.image = img
            })
        }
        
    }
}
