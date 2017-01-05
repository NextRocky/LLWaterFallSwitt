//
//  LLFlowLayout.swift
//  LLWaterFallSwitt
//
//  Created by 罗李 on 17/1/4.
//  Copyright © 2017年 罗李. All rights reserved.
//

import UIKit

class LLFlowLayout: UICollectionViewFlowLayout {
    var margin: CGFloat = 0
    
    var colNum: NSInteger = 0 {
        didSet {
            for _ in 0..<colNum {
                lastItemY.append(margin)
            }
        }
    }
    
    var clothInfo = [LLClothModel]()
    private var lastItemY = [CGFloat]()
    private var layoutAttributes = [UICollectionViewLayoutAttributes]()
    //  计算
    override func prepareLayout() {
        super.prepareLayout()

        let itemW = (UIScreen.mainScreen().bounds.size.width - margin * (CGFloat(colNum) + 1)) / CGFloat(colNum)
        

        let index = self.clothInfo.count
        for i in 0..<index {
            //  swift indexPath 创建
            let indexPath = NSIndexPath(forRow: i, inSection: 0)
            let layoutAttrib = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            let numCol = i % self.colNum
            let model = self.clothInfo[i]
            let itemH = CGFloat(model.height) * itemW / CGFloat(model.width)
            let itemX = margin + CGFloat(numCol) * (itemW + margin)
            let lastY = lastItemY[numCol]
            let itemY = lastY
            self.lastItemY[numCol] = lastY + itemH + margin
            layoutAttrib.frame = CGRectMake(itemX, itemY, itemW, itemH)
            self.layoutAttributes.append(layoutAttrib);
            
        }
        var lagestY: CGFloat = 0;
        for currentY in lastItemY {
            if currentY > lagestY {
                lagestY = currentY
            }
        }
        let footerW:CGFloat = UIScreen.mainScreen().bounds.size.width
        let footerH:CGFloat = 50;
        let footerX:CGFloat = 0;
        let footerY:CGFloat = lagestY;
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        let footerAttrib = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withIndexPath: indexPath)
        footerAttrib.frame = CGRectMake(footerX, footerY, footerW, footerH)
        layoutAttributes.append(footerAttrib)
    }
    
    override func collectionViewContentSize() -> CGSize {
        let contentH = CGRectGetMaxY((layoutAttributes.last?.frame)!)
        let contentW = UIScreen.mainScreen().bounds.size.width;
        
        return CGSizeMake(contentW, contentH)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
    
    
}
