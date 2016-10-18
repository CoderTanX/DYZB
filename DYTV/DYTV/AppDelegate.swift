//
//  AppDelegate.swift
//  DYTV
//
//  Created by 董宏 on 16/9/16.
//  Copyright © 2016年 谭安溪. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UITabBar.appearance().tintColor = UIColor.orange
        return true
    }


}

