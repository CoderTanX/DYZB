//
//  AmuseViewController.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/24.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit
private let kAmuseMenuViewH: CGFloat = 200
class AmuseViewController: BaseAnchorViewController {

    fileprivate lazy var amuseVM: AmuseViewModel = AmuseViewModel()
    fileprivate lazy var amuseMenuView: AmuseMenuView = {
        let amuseMenuView = AmuseMenuView.amuseMenuView()
        amuseMenuView.frame = CGRect(x: 0, y: -kAmuseMenuViewH, width: kScreenW, height: kAmuseMenuViewH)
        return amuseMenuView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

//MARK: - 请求数据
extension AmuseViewController{
    override func loadData() {
        baseVM = amuseVM
        amuseVM.loadAsumeData {
            self.collectionView.reloadData()
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.amuseMenuView.groups = tempGroups
        }
    }
    override func setupUI() {
        super.setupUI()
        collectionView.contentInset = UIEdgeInsets(top: kAmuseMenuViewH, left: 0, bottom: 0, right: 0)
        collectionView.addSubview(amuseMenuView)
    }
}
