//
//  MainTableViewCell.swift
//  UDMSwift
//
//  Created by OSXVN on 8/15/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    private let heightCollectionView = 260
    private let screenSize = UIScreen.mainScreen().bounds
    var collecttionView: UICollectionView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "idCellSourses")
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
        self.collecttionView.backgroundColor = FlatUIColors.cloudsColor()
        self.collecttionView.clipsToBounds = true
        
        self.collecttionView.registerNib(UINib(nibName: "CoursesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "idCoursesCell")
        self.collecttionView.registerNib(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "idCategoriesCell")
        
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
