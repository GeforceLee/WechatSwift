//
//  TSGlobalHelper.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/7/28.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation

func dispatch_async_safely_to_main_queue(block: ()->()) {
    dispatch_async_safely_to_queue(dispatch_get_main_queue(),block)
}



func dispatch_async_safely_to_queue(queue:dispatch_queue_t, _ block: ()->()) -> Void {
    if queue === dispatch_get_main_queue() && NSThread.isMainThread() {
        block()
    }else {
        dispatch_async(queue) {
            block()
        }
    }
}


func TSAlertView_show(title: String, message: String? = nil ) {
    var theMessage = ""
    
    if message != nil {
        theMessage = message!
    }
    let alertView = UIAlertView(title: title, message: theMessage, delegate: nil, cancelButtonTitle: "取消", otherButtonTitles: "好的")
    
    alertView.show()
    
}