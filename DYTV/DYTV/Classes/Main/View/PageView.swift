//
//  PageView.swift
//  DYTV
//
//  Created by 董宏 on 16/9/17.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

private let titleScrollLineH: CGFloat = 2

class PageView: UIView {
    ///标题数组
    private var titles: [String]
    ///标题label数组
    private lazy var titleLabels: [UILabel] = [UILabel]()
    ///标题的高度
    private var titleViewH: CGFloat
    
    private var currentIndex : Int = 0
    
    ///子视图控制器数组
    private var childVcs: [UIViewController]
    ///父视图
    private weak var parentViewController: UIViewController?
    
    ///顶部的titleView
    private lazy var titleView : UIView = UIView()
    
    ///顶部视图底部的scrollview
    private lazy var titleScrollView : UIScrollView = {
        let titleScrollView = UIScrollView()
        titleScrollView.bounces = false
        titleScrollView.showsHorizontalScrollIndicator = false
        return titleScrollView
    }()
    ///顶部视图底部的可以滑动的细线
    private lazy var titleScrollLine : UIView = {
        let titleScrollLine = UIView()
        titleScrollLine.backgroundColor = UIColor.orangeColor()
        return titleScrollLine
    }()
    
    ///中间的ContentView
    private lazy var contentView: UIScrollView = UIScrollView()
    init(frame: CGRect, titles: [String], titleViewH: CGFloat, childVcs: [UIViewController], parentViewController: UIViewController) {
        self.titles = titles
        self.titleViewH = titleViewH
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//MARK:- 设置UI
extension PageView{
    
    private func setupUI(){
        
        //设置顶部的titleView
        setupTitleView()
        
        //设置中间的ContentView
        setupContentView()
    }
    
}

//MARK:- 设置顶部的TitleView
extension PageView {
    private func setupTitleView(){
        //添加titleView
        titleView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 40)
        addSubview(titleView)
        
        //添加titleScrollView
        titleView.addSubview(titleScrollView)
        titleScrollView.frame = titleView.bounds
        
        //设置titlesLabel
        setupTitleLables()
        //设置底部的细线和底部的滑动细线
        setupTitleViewBottomLineAndScrollLine()
    }
    
    ///设置titlesLabel
    private func setupTitleLables(){
        
        let labelW: CGFloat = titleView.bounds.width/CGFloat(titles.count)
        let labelH: CGFloat = titleView.bounds.height
        for (index,title) in titles.enumerate() {
            let label = UILabel()
            //设置label的属性
            label.textAlignment = .Center
            label.font = UIFont.systemFontOfSize(15)
            label.textColor = UIColor.darkGrayColor()
            label.text = title
            label.tag = index
            //设置frame
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: 0, width: labelW, height: labelH)
            //添加标题
            titleScrollView.addSubview(label)
            
            //给label添加点击手势
            label.userInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
            titleLabels.append(label)
        }
    }
    private func setupTitleViewBottomLineAndScrollLine(){
        //添加底部的细线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.darkGrayColor()
        let bottomH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: titleView.bounds.height - bottomH, width: titleView.bounds.width, height: bottomH)
        addSubview(bottomLine)
        
        guard let firstLabel = titleLabels.first else { return }
        
        firstLabel.textColor = UIColor.orangeColor()
        
        ///添加底部的滑动的细线
        let scrollLineY = titleView.bounds.height - titleScrollLineH
        titleScrollLine.frame = CGRect(x: 0, y: scrollLineY, width: firstLabel.frame.width, height: titleScrollLineH)
        addSubview(titleScrollLine)
    }
}

//MARK:- 设置中间的ContentView
extension PageView {
    private func setupContentView(){
        //添加中间的contentView
        contentView.showsHorizontalScrollIndicator = false
        contentView.contentSize = CGSize(width: bounds.width * CGFloat(childVcs.count), height: bounds.height - titleViewH)
        addSubview(contentView)
        
        //添加子控制器
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        
    }
}

//MARK:- 监听点击事件
extension PageView{
    
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer){
        let currentLabel = tapGes.view as! UILabel
        let previousLabel = titleLabels[currentIndex]
        
        currentLabel.textColor = UIColor.orangeColor()
        previousLabel.textColor = UIColor.darkGrayColor()
        currentIndex = currentLabel.tag
    }
}


