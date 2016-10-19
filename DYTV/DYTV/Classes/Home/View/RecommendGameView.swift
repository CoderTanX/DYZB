//
//  RecommendGameView.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/18.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

private let kGameCellId: String = "kGameCellId"

class RecommendGameView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var groups: [BaseGameModel]?{
        didSet{
            guard let _ = groups else {return}
            collectionView.reloadData()
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        
        collectionView.register(UINib(nibName: "CollectionViewGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellId)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 70, height: collectionView.bounds.height)
    }
}

//MARK: - 快速从xib创建
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.last as! RecommendGameView
    }
}
//MARK: - 数据源方法
extension RecommendGameView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellId, for: indexPath) as! CollectionViewGameCell
        cell.game = groups?[indexPath.row]
        return cell
    }
}

