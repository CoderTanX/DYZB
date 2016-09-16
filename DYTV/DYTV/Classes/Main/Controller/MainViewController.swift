//
//  MainViewController.swift
//  DYTV
//
//  Created by 董宏 on 16/9/16.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Follow")
        addChildVc("Profile")
    }

    private func addChildVc(stroyName: String){
        //获取控制器
        let childVc = UIStoryboard(name: stroyName, bundle: nil).instantiateInitialViewController()!
        //将控制器添加到tabbarController
        addChildViewController(childVc)
    }

}
