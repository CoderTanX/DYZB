//
//  HomeViewController.swift
//  DYTV
//
//  Created by 董宏 on 16/9/16.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {
    ///懒加载中间的内容视图
    private lazy var pageView: PageView = {[weak self] in
        
        let pageViewFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kScreenH -  kStatusBarH - kNavigationBarH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        //添加子视图
        var childVcs = [UIViewController]()
        for _ in 0..<4{
            let childVc = UIViewController()
            childVcs.append(childVc)
        }
        let pageView = PageView(frame: pageViewFrame, titles: titles, titleViewH: 40, childVcs: childVcs, parentViewController: self!)
        return pageView
    }()
    
    //MARK:-系统的回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setupUI()
        
    }

}
//MARK:- 有关UI的设置
extension HomeViewController {
    private func setupUI(){
        
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        view.addSubview(pageView)
        
    }
    
    ///设置NavigationBar
    private func setupNavigationBar(){
        //设置左边的logo的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //设置右边历史按钮
        let historyItem = UIBarButtonItem(imageName: "image_my_history", imageHighName: "Image_my_history_click")
        //设置右边的搜索按钮
        let searchItem = UIBarButtonItem(imageName: "btn_search", imageHighName: "btn_search_clicked", size: CGSize(width: 40, height: 40))
        
        //设置右边的扫描按钮
        let scanItem = UIBarButtonItem(imageName: "Image_scan", imageHighName: "Image_scan_click")
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, scanItem]
        
    }
}