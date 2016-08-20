//
//  CourseVideoCell.swift
//  UDMSwift
//
//  Created by OSXVN on 8/18/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class CourseVideoCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var courseVideo: UIImageView!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var labelPesonName: UILabel!
    @IBOutlet weak var labelReiviewCourse: UILabel!
    @IBOutlet weak var costSourse: UILabel!
    @IBOutlet weak var buttonBuy: UIButton!
    
    //MARK: Method
    override func awakeFromNib() {
        super.awakeFromNib()
        print("print")
    }
}
