//
//  UISearchBar+Extension.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/2.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation

extension UISearchBar {
    var cancelButton: UIButton {
        get {
            var button = UIButton()
            for view in self.subviews {
                for  subView in view.subviews {
                    if subView.isKindOfClass(UIButton) {
                        button = subView as! UIButton
                        return button
                    }
                }
            }
            return button
        }
    }
}