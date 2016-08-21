//
//  MainTableViewCell.swift
//  UDMSwift
//
//  Created by OSXVN on 8/15/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

final class MainTableViewCell: UITableViewCell, ReusableView {
    // MARK: - Properties
    static let ReuseIdentifier: String = "idMainTableViewCell"
    static let NibName: String = "MainTableViewCell"
    
    private let heightCollectionView = 260
    
    lazy var collecttionView: UICollectionView = {
        let frameUICollection = CGRect(x: 0, y: 0, width: Int(UDMConfig.getScreenRect().width), height: 260 + 30)
        let sizeItemCollection = CGSize(width: Int(UDMConfig.getScreenRect().width / 3), height: 260 - 10)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.sectionInset = UIEdgeInsetsMake(5, 10, 10, 10)
        layout.itemSize = sizeItemCollection
        
        let collecttion = UICollectionView(frame: frameUICollection, collectionViewLayout: layout)
        collecttion.showsHorizontalScrollIndicator = false
        collecttion.backgroundColor = UIColor.flatWhiteColor()
        collecttion.clipsToBounds = true
        return collecttion
    }()
    
    // MARK: - Initializetion
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.layoutMargins = UIEdgeInsetsZero
        self.preservesSuperviewLayoutMargins = false
        
        collecttionView.registerNib(UINib(nibName: CoursesCollectionViewCell.NibName, bundle: nil), forCellWithReuseIdentifier: CoursesCollectionViewCell.ReuseIdentifier)
        collecttionView.registerNib(UINib(nibName: CategoriesCollectionViewCell.NibName, bundle: nil), forCellWithReuseIdentifier: CategoriesCollectionViewCell.ReuseIdentifier)
        
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
