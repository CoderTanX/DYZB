//
//  PageTitleView.swift
//  DYTV
//
//  Created by 董宏 on 16/9/17.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

private let scrollLineH: CGFloat = 2

class PageTitleView: UIView {
    
    private var titles:[String]
    
    private lazy var titleLabels: [UILabel] = [UILabel]()
    private lazy var scrollView : UIScrollView = {
        let scrolleView = UIScrollView()
        scrolleView.bounces = false
        scrolleView.showsHorizontalScrollIndicator = false
        return scrolleView
    }()
    
    ///底部的可以滑动的细线
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orangeColor()
        return scrollLine
    }()
    
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK:- 设置UI界面
extension PageTitleView {
    
    private func setupUI(){
        //添加背景的scrollview
        scrollView.frame = bounds
        addSubview(scrollView)
        
        //设置titlesLabel
        setupTitleLables()
        
        //设置底部的细线和底部的滑动细线
        setupBottomLineAndScrollLine()
    
    }
    
    ///设置titlesLabel
    private func setupTitleLables(){
        
        let labelW: CGFloat = bounds.width/CGFloat(titles.count)
        let labelH: CGFloat = bounds.height
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
            scrollView.addSubview(label)
            
            titleLabels.append(label)
                        
        }
    }
    
    ///设置底部的细线和底部的滑动细线
    private func setupBottomLineAndScrollLine(){
        //添加底部的细线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.darkGrayColor()
        let bottomH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: bounds.height - bottomH, width: bounds.width, height: bottomH)
        addSubview(bottomLine)
        
        guard let firstLabel = titleLabels.first else { return }
        
        firstLabel.textColor = UIColor.orangeColor()
        
        ///添加底部的滑动的细线
        let scrollLineY = bounds.height - scrollLineH
        scrollLine.frame = CGRect(x: 0, y: scrollLineY, width: firstLabel.frame.width, height: scrollLineH)
        addSubview(scrollLine)
        
    }
    
}
