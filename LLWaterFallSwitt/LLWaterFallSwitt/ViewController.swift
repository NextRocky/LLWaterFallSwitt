//
//  ViewController.swift
//  LLWaterFallSwitt
//
//  Created by 罗李 on 17/1/4.
//  Copyright © 2017年 /Users/luoli/Downloads/我的项目History/LLWaterFallSwitt/CollectionView罗李. All rights reserved.
//

import UIKit

let cellIdentifier = "cell"
let footerIdentifier = "footer"
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    private lazy var pullUpReloadMoreData: UIActivityIndicatorView = {
        let pullUpReloadMoreData = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        pullUpReloadMoreData.frame = CGRectMake(0,0,UIScreen.mainScreen().bounds.size.width,50);
        
        pullUpReloadMoreData.color = UIColor.redColor()
        return pullUpReloadMoreData;
    }()
    private lazy var dataSource:[LLClothModel] = {
       let dataSource = LLClothModel.arrayModelWithPlistName("1.plist")
        return dataSource
    }()
    private lazy var fallCollectionView:UICollectionView = {
//        let flowLayout = UICollectionViewFlowLayout();
//        flowLayout.itemSize = CGSizeMake(100,165)
//        flowLayout.scrollDirection = .Vertical
//        flowLayout.minimumLineSpacing = 5
//        flowLayout.minimumInteritemSpacing = 5
        
        let flowLayout = LLFlowLayout()
        flowLayout.margin = 5
        flowLayout.colNum = 3;
        flowLayout.clothInfo = self.dataSource
        let fallCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)

        
        return fallCollectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }

    func setupCollectionView() {
        fallCollectionView.delegate = self;
        fallCollectionView.dataSource = self
        fallCollectionView.backgroundColor = UIColor.whiteColor()
        view.addSubview(fallCollectionView)
        //  swift class 用class
        fallCollectionView.registerClass(LLCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        fallCollectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerIdentifier)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let model = self.dataSource[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! LLCollectionViewCell
        
        cell.cellDataSource = model;
        return cell;
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeMake(UIScreen.mainScreen().bounds.size.width, 50);
    }
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == dataSource.count - 1 {
            pullUpReloadMoreData.startAnimating()
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), { () -> Void in
                self.pullUpReloadMoreData.stopAnimating()
                self.reloadModeData()

            })
        }
    }
    
    func reloadModeData(){
        let arr:[LLClothModel] = LLClothModel.arrayModelWithPlistName("1.plist");
        for model in arr {
            self.dataSource.insert(model, atIndex: 0)
            fallCollectionView.reloadData()
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var key: String = ""
        if kind == UICollectionElementKindSectionFooter {
            key = footerIdentifier
            
        }
        let footer = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: key, forIndexPath: indexPath)
        footer.addSubview(pullUpReloadMoreData)
        return footer
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

