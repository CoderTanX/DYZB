//
//  RecommendViewController.swift
//  DYTV
//
//  Created by 谭安溪 on 16/9/19.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

private let itemMargin: CGFloat = 10
private let itemW = (kScreenW - 3 * itemMargin) / 2
private let itemNormalH = itemW * 3/4
private let itemPreetyH = itemW * 4/3
private let kNormalCellId: String = "kNormalCellId"
private let kPrettyCellId: String = "kPrettyCellId"
private let kSectionHeaderId: String = "kSectionHeaderId"

private let kCycleViewH: CGFloat = kScreenW * 3/8
private let kGameViewH: CGFloat = 90

class RecommendViewController: UIViewController {
    
    fileprivate lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemW, height: itemNormalH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = itemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: itemMargin, bottom: 0, right: itemMargin)
        //设置section头视图大小
        layout.headerReferenceSize = CGSize(width: kScreenW, height: 50)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //设置内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH+kGameViewH, left: 0, bottom: 0, right: 0)
        collectionView.dataSource = self
        collectionView.delegate = self
        //注册普通cell
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellId)
        //注册颜值的cell
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellId)
        //注册sectionHead
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderId)
        return collectionView
    }()
    
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
    
    
    //MARK: - 系统的回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI()
        //数据请求
        loadData()
        
    }
}

//MARK: - 设置UI界面相关

extension RecommendViewController{
    fileprivate func setupUI(){
        //添加中间的collectionView
        view.addSubview(collectionView)
        //添加顶部的轮播图
        collectionView.addSubview(cycleView)
        //添加推荐游戏
        collectionView.addSubview(gameView)
    }
}

//MARK: - 请求数据
extension RecommendViewController{
    
    fileprivate func loadData(){
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


//MARK: - 设置collection的数据源和代理方法
extension RecommendViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       let group = recommendVM.anchorGroups[section]
       return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : CollectionBasicCell!
        if (indexPath as NSIndexPath).section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellId, for: indexPath) as! CollectionPrettyCell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath) as! CollectionNormalCell
        }
        let group = self.recommendVM.anchorGroups[indexPath.section]
        cell.anchor = group.anchors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderId, for: indexPath) as! CollectionHeaderView
        headerView.group = self.recommendVM.anchorGroups[indexPath.section]
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath as NSIndexPath).section == 1 {
            return CGSize(width: itemW, height: itemPreetyH)
        }
        return CGSize(width: itemW, height: itemNormalH)
    }
    
}
