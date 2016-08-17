//
//  SearchCoursesViewController.swift
//  UDMSwift
//
//  Created by Hanbiro on 8/17/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class SearchCoursesViewController: UIViewController {

    //MARK: Properties
    private let screenSize = UIScreen.mainScreen().bounds
    private var mySearchBar: UISearchBar!
    //MARK: IBOutlet properties
    @IBOutlet weak var tableTopKeySearch: UITableView!
    //MARK: Data
    var listTopKeySearch: [String]!
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        listTopKeySearch = ["ios", "c++", "java", "swift", ".Net", "python", "web"]
        
        // Search bar
        mySearchBar = UISearchBar()
        mySearchBar.delegate = self
        mySearchBar.sizeToFit()
        mySearchBar.placeholder = "Search"
        self.navigationItem.titleView = mySearchBar
        self.navigationController?.navigationBar.barTintColor = FlatUIColors.emeraldColor()
        
        tableTopKeySearch.tableFooterView = UIView()
    }
}
//MARK: TableView
extension SearchCoursesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTopKeySearch.count
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleHeader = UILabel()
        titleHeader.textAlignment = .Center
        titleHeader.text = "Top Key Search"
        return titleHeader
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Top Key Search"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellTable = tableView.dequeueReusableCellWithIdentifier("idDefaultCell", forIndexPath: indexPath)
        cellTable.textLabel?.textAlignment = .Center
        cellTable.textLabel?.textColor = FlatUIColors.emeraldColor()
        cellTable.textLabel?.text = listTopKeySearch[indexPath.row]
        return cellTable
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("click row \(indexPath.row)")
    }
}
//MARK: SearchBar
extension SearchCoursesViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        mySearchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    }
}
