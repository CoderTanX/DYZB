//
//  AsumeViewModel.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/19.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class AsumeViewModel {
    var anchorGroups: [AnchorGroup] = [AnchorGroup]()
}
//MARK: - 请求数据
extension AsumeViewModel {
    func requestAsumeData(finishedCallBack: @escaping () -> ()){
        NetworkTools.requsetData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
            guard let dataArray = result["data"] as? [[String: Any]] else { return }
            for dict in dataArray{
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            finishedCallBack()
        }
    }
}
