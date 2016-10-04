//
//  CourseReviewsCell.swift
//  UDMSwift
//
//  Created by OSXVN on 8/18/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

final class CourseReviewsCell: UITableViewCell, ReusableView {
    // MARK: - Properties
    static let ReuseIdentifier: String = "idCourseReviewsCell"
    static let NibName: String = "CourseReviewsCell"
    
    @IBOutlet weak var titleReview: UILabel!
    @IBOutlet weak var scoresReviews: UILabel!
    @IBOutlet weak var tableReviews: UITableView!
    @IBOutlet weak var buttonSeeAll: UIButton!
    
    var arrayReview = [String]()
    
    // MARK: - Initialzation
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableReviews.estimatedRowHeight = 44.0
        tableReviews.rowHeight = UITableViewAutomaticDimension
        tableReviews.dataSource = self
        tableReviews.delegate = self
        tableReviews.contentInset = UIEdgeInsetsZero;
        
        arrayReview = ["1", "2", "3", "4", "5", "6", "7"]
    }
}
// MARK: - Table View
extension CourseReviewsCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayReview.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellTable = tableView.dequeueReusableCellWithIdentifier(ReviewsCell.ReuseIdentifier) as? ReviewsCell
        if cellTable == nil {
            tableReviews.registerNib(UINib(nibName: ReviewsCell.NibName, bundle: nil), forCellReuseIdentifier: ReviewsCell.ReuseIdentifier)
            cellTable = tableView.dequeueReusableCellWithIdentifier(ReviewsCell.ReuseIdentifier) as? ReviewsCell
        }
        return cellTable!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Clicked row: \(indexPath.row)")
    }
}
