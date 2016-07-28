//
//  TSApplicationManager.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/7/28.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation



class TSApplicationManager: NSObject {
    static func applicationConfigInit(){
        self.initNavigationBar()
        self.initNotifications()
        TSProgressHUD.ts_initHUD()
        LocationInstance.startLocation({}, failure: {})
        
    }
    
    
    static func initNavigationBar() {
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        UINavigationBar.appearance().barTintColor = UIColor(colorNamed: TSColor.barTintColor)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().translucent = true
        
        let attributes = [
            NSFontAttributeName:UIFont.systemFontOfSize(19.0),
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
       UINavigationBar.appearance().titleTextAttributes = attributes
        
    }
    
    
    
    static func initNotifications(){
        let setting = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(setting)
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
}