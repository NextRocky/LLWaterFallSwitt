//
//  LLClothModel.swift
//  LLWaterFallSwitt
//
//  Created by 罗李 on 17/1/4.
//  Copyright © 2017年 罗李. All rights reserved.
//

import UIKit

class LLClothModel: NSObject {

    var icon: String?
    var price: String?
    var height: NSInteger = 0
    var width: NSInteger = 0;
    init(dic: [String: AnyObject]) {
     
        super.init()
        setValuesForKeysWithDictionary(dic)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        
    }
    class func arrayModelWithPlistName(plistName:String) -> [LLClothModel] {
        let path = NSBundle.mainBundle().pathForResource(plistName, ofType: nil)
        let dataArr = NSArray(contentsOfFile: path!)
        var muArr = [LLClothModel]()
        dataArr?.enumerateObjectsUsingBlock({ (dic, num, _) -> Void in
            let model = LLClothModel(dic: dic as! [String : AnyObject]);
            muArr.append(model)
        })
        return muArr
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
