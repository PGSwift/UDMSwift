//
//  CourseCurriculumCell.swift
//  UDMSwift
//
//  Created by OSXVN on 8/18/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class CourseCurriculumCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var titleCurriculumCell: UILabel!
    @IBOutlet weak var titleNumber: UILabel!
    @IBOutlet weak var buttonSeeAll: UIButton!
    @IBOutlet weak var tableCurriculum: UITableView!
}

extension CourseCurriculumCell: UITableViewDataSource, UITableViewDelegate {
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
