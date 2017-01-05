//
//  LLCollectionViewCell.swift
//  LLWaterFallSwitt
//
//  Created by 罗李 on 17/1/4.
//  Copyright © 2017年 罗李. All rights reserved.
//

import UIKit

class LLCollectionViewCell: UICollectionViewCell {

    var cellDataSource:LLClothModel? {
        didSet{
            iconImageView.image = UIImage(named: (cellDataSource?.icon)!)
        }
    }
    private lazy var iconImageView:UIImageView = {
        let iconImageView = UIImageView(image: UIImage(named: "1_kqyvkx2dkfbfqwtwgfjeg5sckzsew_410x591.jpg_200x999"))
        
        return iconImageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    func setupUI() {
        contentView.addSubview(iconImageView);
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.frame = contentView.bounds;
    }
}
