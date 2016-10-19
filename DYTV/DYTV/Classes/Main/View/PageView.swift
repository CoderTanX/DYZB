//
//  PageView.swift
//  DYTV
//
//  Created by 董宏 on 16/9/17.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

private let titleScrollLineH: CGFloat = 2

private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)


class PageView: UIView {
    ///标题数组
    fileprivate var titles: [String]
    ///标题label数组
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    ///标题的高度
    fileprivate var titleViewH: CGFloat
    
    ///子视图控制器数组
    fileprivate var childVcs: [UIViewController]
    ///父视图
    fileprivate weak var parentViewController: UIViewController?
    
    ///顶部的titleView
    fileprivate lazy var titleView : UIView = UIView()
    
    ///顶部视图底部的scrollview
    fileprivate lazy var titleScrollView : UIScrollView = {
        let titleScrollView = UIScrollView()
        titleScrollView.bounces = false
        titleScrollView.showsHorizontalScrollIndicator = false
        return titleScrollView
    }()
    ///顶部视图底部的可以滑动的细线
    fileprivate lazy var titleScrollLine : UIView = {
        let titleScrollLine = UIView()
        titleScrollLine.backgroundColor = UIColor.orange
        return titleScrollLine
    }()
    
    ///中间的ContentView
    fileprivate lazy var contentView: UIScrollView = UIScrollView()
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
    
    fileprivate func setupUI(){
        
        //设置顶部的titleView
        setupTitleView()
        
        //设置中间的ContentView
        setupContentView()
    }
    
}

//MARK:- 设置顶部的TitleView
extension PageView {
    fileprivate func setupTitleView(){
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
    fileprivate func setupTitleLables(){
        
        let labelW: CGFloat = titleView.bounds.width/CGFloat(titles.count)
        let labelH: CGFloat = titleView.bounds.height
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
            titleScrollView.addSubview(label)
            
            //给label添加点击手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
            titleLabels.append(label)
            if index == 0 {
                titleLabelClick(tapGes)
            }
        }
    }
    fileprivate func setupTitleViewBottomLineAndScrollLine(){
        //添加底部的细线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.darkGray
        let bottomH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: titleView.bounds.height - bottomH, width: titleView.bounds.width, height: bottomH)
        addSubview(bottomLine)
        
        guard let firstLabel = titleLabels.first else { return }
        
        firstLabel.textColor = UIColor.orange
        
        ///添加底部的滑动的细线
        let scrollLineY = titleView.bounds.height - titleScrollLineH
        titleScrollLine.frame = CGRect(x: 0, y: scrollLineY, width: firstLabel.frame.width, height: titleScrollLineH)
        addSubview(titleScrollLine)
    }
}

//MARK:- 设置中间的ContentView
extension PageView {
    fileprivate func setupContentView(){
        //添加中间的contentView
        contentView.frame = CGRect(x: 0, y: titleViewH, width: bounds.width, height: bounds.height - titleViewH - kTabBarH)
        contentView.showsHorizontalScrollIndicator = false
        contentView.isPagingEnabled = true
        contentView.bounces = false
        contentView.delegate = self
        contentView.contentSize = CGSize(width: contentView.bounds.width * CGFloat(childVcs.count), height: contentView.bounds.height - titleViewH - kTabBarH)
        addSubview(contentView)
        
        //添加子控制器
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        
    }
}

//MARK:- 监听点击事件
extension PageView{
    
    @objc fileprivate func titleLabelClick(_ tapGes: UITapGestureRecognizer){
        let currentLabel = tapGes.view as! UILabel
        //给contentView添加子视图
        let childVc : UIViewController = childVcs[currentLabel.tag]
        let childVcX = CGFloat(currentLabel.tag) * contentView.bounds.width
        childVc.view.frame = CGRect(x: childVcX, y: 0, width: contentView.bounds.width, height: contentView.bounds.height)
        
        contentView.addSubview(childVc.view)
        contentView.setContentOffset(CGPoint(x: childVcX, y: 0), animated: true)
        
    }
}

//MARK: - uiscrollview的代理
extension PageView: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x
        let index = Int(offsetX / scrollView.bounds.width)
        let label = titleLabels[index]
        titleLabelClick(label.gestureRecognizers?.first as! UITapGestureRecognizer)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.x/scrollView.bounds.width)
        let radio: CGFloat = scrollView.contentOffset.x/scrollView.bounds.width
        //设置底部滑动细线frame
        self.titleScrollLine.frame.origin.x = radio * titleScrollLine.bounds.width
        //判断是向左滑动还是向右滑动
        let sourceIndex : Int = Int(radio)
        var targetIndex : Int = 0
        var progress: CGFloat = 0
        if CGFloat(sourceIndex) < radio {
            targetIndex = Int(ceil(radio))
            progress = 1 - ceil(radio) + radio
        }else{
            targetIndex = Int(floor(radio))
            progress = 1 - radio + floor(radio)
        }
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
    }
}


