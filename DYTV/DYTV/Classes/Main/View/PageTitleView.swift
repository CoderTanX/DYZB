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
    
    fileprivate var titles:[String]
    
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrolleView = UIScrollView()
        scrolleView.bounces = false
        scrolleView.showsHorizontalScrollIndicator = false
        return scrolleView
    }()
    
    ///底部的可以滑动的细线
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
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
    
    fileprivate func setupUI(){
        //添加背景的scrollview
        scrollView.frame = bounds
        addSubview(scrollView)
        
        //设置titlesLabel
        setupTitleLables()
        
        //设置底部的细线和底部的滑动细线
        setupBottomLineAndScrollLine()
    
    }
    
    ///设置titlesLabel
    fileprivate func setupTitleLables(){
        
        let labelW: CGFloat = bounds.width/CGFloat(titles.count)
        let labelH: CGFloat = bounds.height
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            //设置label的属性
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = UIColor.darkGray
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
    fileprivate func setupBottomLineAndScrollLine(){
        //添加底部的细线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.darkGray
        let bottomH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: bounds.height - bottomH, width: bounds.width, height: bottomH)
        addSubview(bottomLine)
        
        guard let firstLabel = titleLabels.first else { return }
        
        firstLabel.textColor = UIColor.orange
        
        ///添加底部的滑动的细线
        let scrollLineY = bounds.height - scrollLineH
        scrollLine.frame = CGRect(x: 0, y: scrollLineY, width: firstLabel.frame.width, height: scrollLineH)
        addSubview(scrollLine)
        
    }
    
}
