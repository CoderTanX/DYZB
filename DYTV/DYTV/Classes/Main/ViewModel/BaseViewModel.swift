//
//  BaseViewModel.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/21.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class BaseViewModel {
    var anchorGroups: [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel{
    func loadAnchorData(URLString: String, parameters: [String: Any]? = nil, finishedCallBack: @escaping () -> ()){
        NetworkTools.requsetData(.GET, URLString: URLString, parameters: parameters) { (result) in
            guard let dataArray = result["data"] as? [[String: Any]] else { return }
            for dict in dataArray{
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            finishedCallBack()
        }
    }
}
