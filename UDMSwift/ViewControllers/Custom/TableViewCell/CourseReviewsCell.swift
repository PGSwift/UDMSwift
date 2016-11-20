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
    
    var reviewDict = [[String: AnyObject]]()
    var isHiden = false
    
    var idCourses = ""
    
    // MARK: - Initialzation
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableReviews.estimatedRowHeight = 44.0
        tableReviews.rowHeight = UITableViewAutomaticDimension
        tableReviews.dataSource = self
        tableReviews.delegate = self
        tableReviews.contentInset = UIEdgeInsetsZero

    }
    
    func reloadData() {
        let data1 = UDMInfoDictionaryBuilder.shareInstance.getRateList(withCourseId: idCourses)
        UDMService.shareInstance.getListDataFromServer(with: data1, Completion: { (data, success) in
            if success {
                
                guard let Cdata = data["data"] as? [[String: AnyObject]] else {
                    println("Not found data caches")
                    return
                }
                
                println("data review: \(Cdata)")
                self.reviewDict = Cdata
                if self.reviewDict.count == 0 {
                    self.isHiden = true
                    let dataTemp = ["key": "value"]
                    self.reviewDict.append(dataTemp)
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    self.tableReviews.reloadData()
                })
            } else {
                println("ERROR message: \(data["message"]!)")
            }
        })
    }
}
// MARK: - Table View
extension CourseReviewsCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewDict.count
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
        
        if isHiden {
            cellTable?.dateReview.hidden = isHiden
            cellTable?.nameReviewer.hidden = isHiden
            cellTable?.ratingControl.hidden = isHiden
            cellTable?.textViewContents.hidden = isHiden
            cellTable?.titleLabel.hidden = isHiden
            cellTable?.noReviews.hidden = !isHiden
            return cellTable!
        }
        
        
        let data = reviewDict[indexPath.row]
        var r = 0.0
        if let rating = data["value"] as? String {
            r = Double(rating)!
        }
        
        cellTable?.dateReview.text = (data["dateRate"] as? String) ?? "NULL"
        cellTable?.nameReviewer.text = (data["userName"] as? String) ?? "NULL"
        cellTable?.ratingControl.rating = r
        cellTable?.textViewContents.text = (data["description"] as? String) ?? "NULL"
        cellTable?.titleLabel.text = (data["title"] as? String) ?? "NULL"
        
        return cellTable!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Clicked row: \(indexPath.row)")
    }
}
