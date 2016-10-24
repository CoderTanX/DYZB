//
//  AmuseViewModel.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/24.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {

}

//MARK: - 请求数据
extension AmuseViewModel {
    func loadAsumeData(finishedCallBack: @escaping () -> ()){
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallBack: finishedCallBack)
    }
}
