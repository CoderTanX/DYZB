//
//  BaseGameModel.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/19.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    // MARK:- 定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override init() {
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
