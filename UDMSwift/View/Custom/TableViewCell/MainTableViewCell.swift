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
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "idCellSourses")
        
        collection.registerNib(UINib(nibName: "CoursesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "idCoursesCell")
        collection.registerNib(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "idCategoriesCell")
        
        self.collecttionView = collection
        self.contentView.addSubview(self.collecttionView)
        self.backgroundColor = UIColor.clearColor()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
