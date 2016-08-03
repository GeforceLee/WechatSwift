//
//  UIView+Extension.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/2.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation

extension UIView {
    class func NibObject() -> UINib {
        let hasNib: Bool = NSBundle.mainBundle().pathForResource(self.nameOfClass, ofType: "nib") != nil
        
        guard hasNib else {
            assert(!hasNib, "Invalid parameter")
            return UINib()
        }
        return UINib(nibName: self.nameOfClass, bundle: nil)
    }
    
    
    
    class func fromNib<T: UIView>(nibNameOrNil: String? = nil) -> T {
        let v: T? = fromNib(nibNameOrNil)
        return v!
    }
    
    
    class func fromNib<T: UIView>(nibNameOrNil: String? = nil) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            name = T.nameOfClass
        }
        
        let nibViews = NSBundle.mainBundle().loadNibNamed(name, owner: nil, options: nil)
        for v in nibViews {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }
}