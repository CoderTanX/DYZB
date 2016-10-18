                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                //
//  PageContentView.swift
//  DYTV
//
//  Created by 董宏 on 16/9/17.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

class PageContentView: UIScrollView {
    
    fileprivate var childVcs: [UIViewController]
    fileprivate var parentViewController: UIViewController
    
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
///设置UI界面
extension PageContentView {
    
    fileprivate func setupUI(){
        //设置scrollview
        contentSize = CGSize(width: bounds.width * CGFloat(childVcs.count), height: bounds.width)
        showsHorizontalScrollIndicator = false
        //添加自控制器
        for childVc in childVcs {
            parentViewController .addChildViewController(childVc)
        }
    }
}




