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
    private weak var collecttionView: UICollectionView!
    
    init (collection: UICollectionView) {
        collection.frame = CGRect(x: 0, y: 0, width: Int(screenSize.width), height: heightCollectionView)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = UIColor.cyanColor()
        
        if let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = screenSize.width / 3.0
            let itemHeight = heightCollectionView - 10
            layout.itemSize = CGSize(width: Int(itemWidth), height: itemHeight)
            layout.invalidateLayout()
        }
        
        collection.registerNib(UINib(nibName: "CoursesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "idCoursesCell")
        collection.registerNib(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "idCategoriesCell")
        
        self.collecttionView = collection
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "idCellSourses")
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
