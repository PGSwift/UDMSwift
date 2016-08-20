//
//  CourseReviewsCell.swift
//  UDMSwift
//
//  Created by OSXVN on 8/18/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class CourseReviewsCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var titleReview: UILabel!
    @IBOutlet weak var scoresReviews: UILabel!
    @IBOutlet weak var tableReviews: UITableView!
    @IBOutlet weak var buttonSeeAll: UIButton!
    
    let idReviewsCell = "idReviewsCell"
    
    var arrayReview = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableReviews.estimatedRowHeight = 44.0
        tableReviews.rowHeight = UITableViewAutomaticDimension
        arrayReview = ["1", "2", "3", "4", "5", "6", "7"]
        tableReviews.dataSource = self
        tableReviews.delegate = self
    }
}
//MARK: Table View
extension CourseReviewsCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayReview.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellTable = tableView.dequeueReusableCellWithIdentifier(idReviewsCell) as? ReviewsCell
        if cellTable == nil {
            tableReviews.registerNib(UINib(nibName: "ReviewsCell", bundle: nil), forCellReuseIdentifier: idReviewsCell)
            cellTable = tableView.dequeueReusableCellWithIdentifier(idReviewsCell) as? ReviewsCell
        }
        return cellTable!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Clicked row: \(indexPath.row)")
    }
}
