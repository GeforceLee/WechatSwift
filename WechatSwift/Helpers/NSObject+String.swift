//
//  NSObject+String.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/2.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation

extension NSObject {
    class var nameOfClass: String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
    
    class var identifier: String{
        return String(format: "%@_identifier", self.nameOfClass)
    }
}