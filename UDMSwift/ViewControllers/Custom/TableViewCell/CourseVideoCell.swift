//
//  CourseVideoCell.swift
//  UDMSwift
//
//  Created by OSXVN on 8/18/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit
import Cosmos

final class CourseVideoCell: UITableViewCell, ReusableView {
    // MARK: - Properties
    static let ReuseIdentifier: String = "idCourseVideoCell"
    static let NibName: String = "CourseVideoCell"
    
    @IBOutlet weak var courseVideo: UIImageView!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var labelPesonName: UILabel!
    @IBOutlet weak var costSourse: UILabel!
    @IBOutlet weak var buttonBuy: UIButton!

    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var ratingControl: CosmosView!
    // MARK: - Method
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
