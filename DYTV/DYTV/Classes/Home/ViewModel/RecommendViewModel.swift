//
//  RecommendViewModel.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/17.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class RecommendViewModel: BaseViewModel {
    /// 轮播图
    lazy var cycleModels: [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup: AnchorGroup = AnchorGroup()
}

//MARK: - 请求数据
extension RecommendViewModel{
    func requestData(finishedCallBack: @escaping ()->()){
        let dGruop = DispatchGroup()
        dGruop.enter()
        //发送热门请求
        NetworkTools.requsetData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getTimeStamp()]) { (result) in
            guard let dataArray = result["data"] as? [[String: Any]] else { return }
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            dGruop.leave()
        }
        // 参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getTimeStamp()]
        dGruop.enter()
        //发送颜值请求
        NetworkTools.requsetData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            guard let dataArray = result["data"] as? [[String: Any]] else { return }
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dGruop.leave()
        }
        
        dGruop.enter()
        //剩余部分的请求
//        NetworkTools.requsetData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
//            guard let dataArray = result["data"] as? [[String: Any]] else { return }
//            for dict in dataArray{
//                let group = AnchorGroup(dict: dict)
//                self.anchorGroups.append(group)
//            }
//            dGruop.leave()
//        }
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { 
            dGruop.leave()
        }
        dGruop.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishedCallBack()
        }
        
    }
    /// 请求轮播图数据
    ///
    /// - parameter finishedCallBack: 回调
    func requsetCycleData(finishedCallBack:@escaping ()->()){
        NetworkTools.requsetData(.GET, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            guard let dataArray = result["data"] as? [[String: Any]] else { return }
            for dict in dataArray{
                let cycleModel = CycleModel(dict: dict)
                self.cycleModels.append(cycleModel)
                finishedCallBack()
            }
        }
    }
}
