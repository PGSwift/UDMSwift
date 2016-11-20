//
//  CourseCell.swift
//  UDMSwift
//
//  Created by OSXVN on 8/18/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit
import Cosmos

final class CourseCell: UITableViewCell, ReusableView {
    // MARK: - Properties
    static let ReuseIdentifier: String = "idCourseCell"
    static let NibName: String = "CourseCell"
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var moneyTextField: UILabel!
    @IBOutlet weak var moneyNew: UILabel!
    @IBOutlet weak var ratingControl: CosmosView!
    // MARK: - Initialzation
    override func awakeFromNib() {
        super.awakeFromNib()
        moneyTextField.textColor = ChameleonManger.textTheme()
        ratingControl.userInteractionEnabled = false
        
    }
    
}
