//
//  CourseDescription.swift
//  UDMSwift
//
//  Created by OSXVN on 8/18/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class CourseDescriptionCell: UITableViewCell, ReusableView {
    // MARK: - Properties
    static let ReuseIdentifier: String = "idCourseDescriptionCell"
    static let NibName: String = "CourseDescriptionCell"
    
    @IBOutlet weak var titleDescription: UILabel!
    @IBOutlet weak var textViewContent: UITextView!
    @IBOutlet weak var buttonSeeAll: UIButton!
    
    // MARK: - Method
    override func awakeFromNib() {
        super.awakeFromNib()
        textViewContent.sizeToFit()
        textViewContent.scrollEnabled = false
        textViewContent.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.xdgdg"
    }
    
}
