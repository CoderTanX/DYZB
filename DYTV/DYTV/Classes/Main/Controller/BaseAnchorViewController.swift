//
//  BaseAnchorViewController.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/24.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

private let itemMargin: CGFloat = 10
let itemW = (kScreenW - 3 * itemMargin) / 2
let itemNormalH = itemW * 3/4
let itemPreetyH = itemW * 4/3

private let kNormalCellId: String = "kNormalCellId"
let kPrettyCellId: String = "kPrettyCellId"
private let kSectionHeaderId: String = "kSectionHeaderId"

class BaseAnchorViewController: UIViewController {
    
        var baseVM: BaseViewModel!
    
        lazy var collectionView: UICollectionView = {[unowned self] in
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}

//MARK: - 设置UI界面
extension BaseAnchorViewController{
    func setupUI(){
        view.addSubview(collectionView)
    }
}

//MARK: - 请求数据
extension BaseAnchorViewController{
    func loadData(){
        
    }
}

//MARK: - 数据源方法
extension BaseAnchorViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath) as! CollectionNormalCell
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kSectionHeaderId, for: indexPath) as! CollectionHeaderView
        headerView.group = baseVM.anchorGroups[indexPath.section]
        return headerView
    }
}
