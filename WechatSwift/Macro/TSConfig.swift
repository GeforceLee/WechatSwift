//
//  TSConfig.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/7/26.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation


class TSConfig {
    static let testUserID = "wx1234skjksmsjdfwe234"
    static let ExpressionBundle = NSBundle(URL: NSBundle.mainBundle().URLForResource("Expression", withExtension: "bundle")!)
    static let ExpressionBundleName = "Expression.bundle"
    static let ExpressionPlist = NSBundle.mainBundle().pathForResource("Expression", ofType: "plist")
}