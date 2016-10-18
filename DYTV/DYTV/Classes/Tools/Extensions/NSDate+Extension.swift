//
//  NSDate+Extension.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/17.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import Foundation

extension NSDate{
    //获取当前时间戳
    static func getTimeStamp() -> String{
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
    
}
