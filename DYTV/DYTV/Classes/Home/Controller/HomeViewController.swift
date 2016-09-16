//
//  HomeViewController.swift
//  DYTV
//
//  Created by 董宏 on 16/9/16.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setupUI()
        
    }

}
//MARK:- 有关UI的设置
extension HomeViewController {
    private func setupUI(){
        setupNavigationBar()
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