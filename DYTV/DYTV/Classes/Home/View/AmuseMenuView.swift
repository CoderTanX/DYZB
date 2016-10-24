//
//  AmuseMenuView.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/24.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

private let kAmuseMenuCellId = "kAmuseMenuCellId"
class AmuseMenuView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var groups: [AnchorGroup]?{
        didSet{
            guard let groups = groups else { return }
            pageControl.numberOfPages = (groups.count - 1)/8 + 1
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        //注册cell
        collectionView.register(UINib(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kAmuseMenuCellId)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}
//MARK: - 快速创建
extension AmuseMenuView {
    static func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.last as! AmuseMenuView
    }
}
//MARK: - collectionView的数据源
extension AmuseMenuView: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let groups = groups else { return 0 }
        return (groups.count - 1)/8 + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseMenuCellId, for: indexPath) as! AmuseMenuViewCell
        setCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    //给cell绑定数据
    private func setCellDataWithCell(cell: AmuseMenuViewCell, indexPath: IndexPath){
        let startIndex = indexPath.item * 8
        var endIndex = startIndex + 7
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        cell.groups = Array(groups![startIndex...endIndex])
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x/scrollView.bounds.width)
    }
}
