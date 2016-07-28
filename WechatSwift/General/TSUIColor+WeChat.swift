//
//  TSUIColor+WeChat.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/7/28.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import UIColor_Hex_Swift

typealias TSColor = UIColor.LocalColorName

extension UIColor {
    enum LocalColorName: String {
        case barTintColor = "#1A1A1A"
        case tabbarSelectedTextColor = "#68BB1E"
        case viewBackgroundColor = "#E7EBEE"
    }
    
    convenience init!(colorNamed name:LocalColorName) {
        self.init(rgba: name.rawValue)
    }
}

