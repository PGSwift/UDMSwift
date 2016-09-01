//
//  AccountSettingViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 8/27/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

class AccountSettingViewController: UIViewController {
    // MARK: - Properties
    private var arrSetting: [String: String?] = [:]
    var keysName: [String] = []
    var keysValue: [String] = []
    
    @IBOutlet weak var myAvata: UIImageView!
    @IBOutlet weak var settingTable: UITableView!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTable.tableFooterView = UIView()
        arrSetting = UDMUser.shareManager.getListDataUser()
    }
}
// MARK: - UITableView
extension AccountSettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSetting.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cellProfile = tableView.dequeueReusableCellWithIdentifier("idProfileCell")
        if cellProfile == nil {
            cellProfile = UITableViewCell(style: .Default, reuseIdentifier: "idProfileCell")
        }
        guard let title = cellProfile?.contentView.viewWithTag(10) as? UILabel else {
            fatalError()
        }
        
        title.text = Array(arrSetting.keys)[indexPath.row]
        
        guard let value = cellProfile?.contentView.viewWithTag(11) as? UILabel else {
            fatalError()
        }
        value.text = Array(arrSetting.values)[indexPath.row]
        
        return cellProfile!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}
