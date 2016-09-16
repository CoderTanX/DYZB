//
//  UIBarButtonItem+Extension.swift
//  DYTV
//
//  Created by 董宏 on 16/9/16.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(imageName: String, imageHighName: String = "", size: CGSize = CGSizeZero) {
        let btn = UIButton(type: .Custom)
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        if imageHighName != "" {
            btn.setImage(UIImage(named: imageHighName), forState: .Highlighted)
        }
        if size != CGSizeZero {
            btn.frame.size = size
        }else{
            btn.sizeToFit()
        }
        
        self.init(customView: btn)
    }
}