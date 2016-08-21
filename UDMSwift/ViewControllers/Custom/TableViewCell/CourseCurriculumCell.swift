//
//  CourseCurriculumCell.swift
//  UDMSwift
//
//  Created by OSXVN on 8/18/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class CourseCurriculumCell: UITableViewCell, ReusableView {
    // MARK: - Properties
    static let ReuseIdentifier: String = "idCourseCurriculumCell"
    static let NibName: String = "CourseCurriculumCell"
    
    @IBOutlet weak var titleCurriculumCell: UILabel!
    @IBOutlet weak var titleNumber: UILabel!
    @IBOutlet weak var buttonSeeAll: UIButton!
    @IBOutlet weak var tableCurriculum: UITableView!
    
    let tabLabel = 100

    // MARK: - Method init
    override func awakeFromNib() {
        super.awakeFromNib()
        tableCurriculum.delegate = self
        tableCurriculum.dataSource = self
    }
}

extension CourseCurriculumCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellTable = tableView.dequeueReusableCellWithIdentifier(idDefauleCell)
        if cellTable == nil {
            cellTable = UITableViewCell.init(style: .Subtitle, reuseIdentifier: idDefauleCell)
            cellTable?.imageView?.image = UIImage(named: "x")
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            label.layer.cornerRadius = 12.5
            label.layer.borderWidth = 1.0
            label.layer.borderColor = UIColor.blackColor().CGColor
            label.text = "0"
            label.textAlignment = .Center
            label.tag = tabLabel
            label.backgroundColor = UIColor.clearColor()
            
            cellTable?.imageView?.addSubview(label)
            cellTable?.detailTextLabel?.text = "122321332"
            // goi y : thay image co size phu hop va mau trang
        }
        if let labelNumber = cellTable?.imageView?.viewWithTag(tabLabel) as? UILabel {
            labelNumber.text = String(indexPath.row)
        }
        
        cellTable?.textLabel?.text = String(indexPath.row)
        return cellTable!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Clicked row: \(indexPath.row)")
    }
}
