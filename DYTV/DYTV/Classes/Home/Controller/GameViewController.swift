//
//  GameViewController.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/18.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

private let kEdgeMargin: CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5

private let kGameCellId: String = "kGameCellId"
private let kSectionHeaderId: String = "kSectionHeaderId"

private let kGameViewH: CGFloat = 90
private let kTopHeaderViewH: CGFloat = 50
class GameViewController: UIViewController {

    fileprivate lazy var gameVM: GameViewModel = GameViewModel()
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        //设置布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: kScreenW, height: 50)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        //数据源
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        //注册cell
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellId)
        //注册头视图
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderId)
        return collectionView
        
    }()
    
    //推荐游戏
    fileprivate lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    fileprivate lazy var topHeaderView: CollectionHeaderView = {
        let topHeaderView = CollectionHeaderView.collectionHeaderView()
        topHeaderView.frame = CGRect(x: 0, y: -kGameViewH - kTopHeaderViewH, width: kScreenW, height: kTopHeaderViewH)
        topHeaderView.titleLabel.text = "常用"
        topHeaderView.iconImageView.image = UIImage(named: "Img_orange")
        topHeaderView.moreBtn.isHidden = true
        return topHeaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setupUI()
        //请求数据
        loadData()
        
    }

}
//MARK: - 设置UI界面
extension GameViewController{
    fileprivate func setupUI(){
        view.addSubview(collectionView)
        collectionView.addSubview(gameView)
        collectionView.addSubview(topHeaderView)
    }
}

//MARK: - 数据请求
extension GameViewController{
    fileprivate func loadData(){
        gameVM.loadGameData { 
            self.collectionView.reloadData()
            let group = Array(self.gameVM.gameModels[0..<10])
            self.gameView.groups = group
        }
    }
}

//MARK: - collectionView的数据源
extension GameViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.gameModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellId, for: indexPath) as! CollectionViewGameCell
        cell.game = gameVM.gameModels[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kSectionHeaderId, for: indexPath) as! CollectionHeaderView
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }
}
