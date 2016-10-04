//
//  CourseCellDetail.swift
//  UDMSwift
//
//  Created by OSXVN on 10/2/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation

import UIKit
import Cosmos

final class CourseCellDetail: UITableViewCell, ReusableView {
    // MARK: - Properties
    static let ReuseIdentifier: String = "idCourseCellDetail"
    static let NibName: String = "CourseCellDetail"
    
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
        
    }
    
}