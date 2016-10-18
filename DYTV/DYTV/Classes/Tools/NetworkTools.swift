//
//  NetworkTools.swift
//  DYTV
//
//  Created by 谭安溪 on 2016/10/17.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    
    /// 网络请求
    /// - parameter type:             请求的类型
    /// - parameter URLString:        url
    /// - parameter parameters:       参数
    /// - parameter finishedCallBack: 回调函数
    class func requsetData(_ type: MethodType, URLString: String, parameters: [String : Any]? = nil, finishedCallBack:@escaping (_ result : [String : Any]) -> () ){
        //判断类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        //发送请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value as? [String: Any] else{
                print(response.result.error)
                return
            }
            //执行回调
            finishedCallBack(result)
        }
    }
}


