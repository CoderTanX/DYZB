//
//  GameViewModel.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/18.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class GameViewModel {
    var gameModels: [GameModel] = [GameModel]()
}
//MARK: - 请求数据
extension GameViewModel{
    func loadGameData(finishedCallBack: @escaping () -> ()){
        NetworkTools.requsetData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            guard let dataArray = result["data"] as? [[String: Any]] else { return }
            for dict in dataArray{
                let gameModel = GameModel(dict: dict)
                self.gameModels.append(gameModel)
            }
            finishedCallBack()
        }
    }
}
