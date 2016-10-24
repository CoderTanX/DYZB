//
//  RecommendViewController.swift
//  DYTV
//
//  Created by 谭安溪 on 16/9/19.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

private let kCycleViewH: CGFloat = kScreenW * 3/8
private let kGameViewH: CGFloat = 90

class RecommendViewController: BaseAnchorViewController {
    
    fileprivate lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    
    //轮播图
    fileprivate lazy var cycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH-kGameViewH, width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    //推荐游戏
    fileprivate lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
}

//MARK: - 设置UI界面相关

extension RecommendViewController{
    override func setupUI(){
        super.setupUI()
        //添加顶部的轮播图
        collectionView.addSubview(cycleView)
        //添加推荐游戏
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kGameViewH + kCycleViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - 请求数据
extension RecommendViewController{
    
    override func loadData(){
        baseVM = recommendVM
        //请求主播数据
        recommendVM.requestData {
            self.collectionView.reloadData()
            var groups = self.recommendVM.anchorGroups
            groups.removeFirst()
            groups.removeFirst()
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            self.gameView.groups = groups
        }
        //请求轮播图数据
        recommendVM.requsetCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

extension RecommendViewController: UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellId, for: indexPath) as! CollectionPrettyCell
            cell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return cell
        }
        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: itemW, height: itemPreetyH)
        }
        return CGSize(width: itemW, height: itemNormalH)
    }
}




