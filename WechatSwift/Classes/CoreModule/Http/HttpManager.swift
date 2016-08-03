//
//  HttpManager.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/3.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation

public typealias ts_parameters = [String: AnyObject]
public typealias SuccessClosure = AnyObject -> Void
public typealias FailureClosure = NSError -> Void

class HttpManager: NSObject {
    class var sharedInstance: HttpManager {
        struct Static {
            static let instance: HttpManager = HttpManager()
        }
        return Static.instance
    }
    
    private override init() {
         super.init()
    }
}