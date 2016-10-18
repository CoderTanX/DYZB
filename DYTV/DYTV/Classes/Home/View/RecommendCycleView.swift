//
//  RecommendCycleView.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/18.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

private let kCycleCellId: String = "kCycleCellId"
private let maxCount: Int = 10000
class RecommendCycleView: UIView {
    var timer: Timer?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var cycleModels: [CycleModel]?{
        didSet{
            guard let cycleModels = cycleModels else { return }
            collectionView.reloadData()
            pageControl.numberOfPages = cycleModels.count
            let indexPath = IndexPath(item: maxCount * cycleModels.count/2, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            removeTimer()
            addTimer()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        //注册cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellId)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}
//MARK: - 快速创建对象
extension RecommendCycleView{
    static func recommendCycleView() -> RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.last as! RecommendCycleView
    }
}
//MARK: - 代理和数据源的方法
extension RecommendCycleView: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * maxCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModels?[indexPath.item % (cycleModels?.count)!]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + 0.5*collectionView.bounds.size.width
        pageControl.currentPage = Int(offsetX/collectionView.bounds.size.width)%(cycleModels?.count)!
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}
//MARK: - 定时器的操作
extension RecommendCycleView{
    ///添加定时器
    fileprivate func addTimer(){
        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollNext), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    ///移除定时器
    fileprivate func removeTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    @objc fileprivate func scrollNext(){
        // 1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}








