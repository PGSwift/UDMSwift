//
//  SearchCoursesViewController.swift
//  UDMSwift
//
//  Created by Hanbiro on 8/17/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

final class SearchCoursesViewController: UIViewController, ViewControllerProtocol {
    // MARK: - Properties
    private var mySearchBar: UISearchBar!

    @IBOutlet weak var topKeySearchTable: UITableView!

    var listTopKeySearch: [String] = []
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("SearchCoursesControllerID") as! SearchCoursesViewController
    }
    
    func configItems() {
        
        // Search bar
        mySearchBar = UISearchBar()
        mySearchBar.delegate = self
        mySearchBar.sizeToFit()
        mySearchBar.placeholder = "Search"
        self.navigationItem.titleView = mySearchBar
        
        topKeySearchTable.tableFooterView = UIView()
    }
    
    func initData() {
        
         listTopKeySearch = ["ios", "c++", "java", "swift", ".Net", "python", "web"]
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Init screen SearchCoursesViewController")
        
        initData()
        
        configItems()
    }
}
// MARK: - TableView
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
        //cellTable.textLabel?.textColor = FlatUIColors.emeraldColor()
        cellTable.textLabel?.text = listTopKeySearch[indexPath.row]
        return cellTable
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Click row \(indexPath.row)")
    }
}
// MARK: - SearchBar
extension SearchCoursesViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        mySearchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    }
}
