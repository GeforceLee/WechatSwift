//
//  TSAppMacro.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/7/26.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

/// delegate 代理
let TSAppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

/// 沙盒文档路径
let kSandDocumentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]