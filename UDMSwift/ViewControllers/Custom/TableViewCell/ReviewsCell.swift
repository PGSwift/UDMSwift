//
//  ReviewsCell.swift
//  UDMSwift
//
//  Created by OSXVN on 8/19/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class ReviewsCell: UITableViewCell, ReusableView {
    // MARK: - Properties
    static let ReuseIdentifier: String = "idReviewsCell"
    static let NibName: String = "ReviewsCell"
    
    @IBOutlet weak var labelStar: UILabel!
    @IBOutlet weak var nameReviewer: UILabel!
    @IBOutlet weak var dateReview: UILabel!
    @IBOutlet weak var textViewContents: UITextView!
    
    // MARK: - Method init
    override func awakeFromNib() {
        super.awakeFromNib()
        textViewContents.sizeToFit()
        textViewContents.scrollEnabled = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
