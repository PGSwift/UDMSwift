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
}
//MARK: Table View
extension CourseReviewsCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellTable = tableView.dequeueReusableCellWithIdentifier(idDefauleCell)
        if cellTable == nil {
            cellTable = UITableViewCell.init(style: .Default, reuseIdentifier: idDefauleCell)
        }
        return cellTable!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Clicked row: \(indexPath.row)")
    }
}
