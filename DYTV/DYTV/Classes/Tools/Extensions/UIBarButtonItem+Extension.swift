//
//  UIBarButtonItem+Extension.swift
//  DYTV
//
//  Created by 董宏 on 16/9/16.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(imageName: String, imageHighName: String = "", size: CGSize = CGSize.zero) {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: imageName), for: UIControlState())
        if imageHighName != "" {
            btn.setImage(UIImage(named: imageHighName), for: .highlighted)
        }
        if size != CGSize.zero {
            btn.frame.size = size
        }else{
            btn.sizeToFit()
        }
        
        self.init(customView: btn)
    }
}
