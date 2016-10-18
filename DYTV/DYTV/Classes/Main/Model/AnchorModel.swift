//
//  AnchorModel.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/17.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    /// 房间号
    var room_id: String = ""
    /// 主播昵称
    var nickname: String = ""
    /// 房间图片
    var vertical_src: String = ""
    /// 房间名称
    var room_name: String = ""
    /// 城市
    var anchor_city: String = ""
    /// 在线人数
    var online: Int = 0
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
