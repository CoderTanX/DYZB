//
//  CycleModel.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/18.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    ///标题
    var title: String = ""
    /// 图片
    var pic_url: String = ""
    
    /// 主播房间信息
    var room: [String: Any]?{
        didSet{
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    //主播信息
    var anchor: AnchorModel?
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
