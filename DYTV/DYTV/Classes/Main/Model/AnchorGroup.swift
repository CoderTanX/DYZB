//
//  AnchorGroup.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/17.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    var room_list: [[String: Any]]?{
        didSet{
            guard let room_list =  room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    /// 组图标
    var icon_name: String = "home_header_normal"
    /// 该组中拥有的主播
    lazy var anchors: [AnchorModel] = [AnchorModel]()

}
