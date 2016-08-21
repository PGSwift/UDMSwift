//
//  MainTableViewCell.swift
//  UDMSwift
//
//  Created by OSXVN on 8/15/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell, ReusableView {
    // MARK: - Properties
    static let ReuseIdentifier: String = "idMainTableViewCell"
    static let NibName: String = "MainTableViewCell"
    
    private let heightCollectionView = 260
    private let screenSize = UIScreen.mainScreen().bounds
    
    var collecttionView: UICollectionView!
    
    // MARK: - Initializetion
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.layoutMargins = UIEdgeInsetsZero
        self.preservesSuperviewLayoutMargins = false
        
       let frameUICollection = CGRect(x: 0, y: 0, width: Int(screenSize.width), height: 260 + 30)
       let sizeItemCollection = CGSize(width: Int(screenSize.width / 3), height: 260 - 10)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.sectionInset = UIEdgeInsetsMake(5, 10, 10, 10)
        layout.itemSize = sizeItemCollection
        self.collecttionView = UICollectionView(frame: frameUICollection, collectionViewLayout: layout)
        self.collecttionView.showsHorizontalScrollIndicator = false
        self.collecttionView.backgroundColor = UIColor.flatWhiteColor()
        self.collecttionView.clipsToBounds = true
        
        self.collecttionView.registerNib(UINib(nibName: CoursesCollectionViewCell.NibName, bundle: nil), forCellWithReuseIdentifier: CoursesCollectionViewCell.ReuseIdentifier)
        self.collecttionView.registerNib(UINib(nibName: CategoriesCollectionViewCell.NibName, bundle: nil), forCellWithReuseIdentifier: CategoriesCollectionViewCell.ReuseIdentifier)
        
        self.contentView.addSubview(self.collecttionView)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainTableViewCell {
   
    func setCollectionViewDataSourceDelegate<D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>(dataSourceDelegate: D, forRow: Int) {
        collecttionView.delegate = dataSourceDelegate
        collecttionView.dataSource = dataSourceDelegate
        collecttionView.tag = forRow
        collecttionView.reloadData()
    }
}
