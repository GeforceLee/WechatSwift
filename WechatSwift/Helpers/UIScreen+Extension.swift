//
//  UIScreen+Extension.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/2.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation


public extension UIScreen {
    class var size: CGSize {
        return UIScreen.mainScreen().bounds.size
    }
    
    
    class var width: CGFloat {
        return UIScreen.mainScreen().bounds.width
    }
    
    class var height: CGFloat {
        return UIScreen.mainScreen().bounds.height
    }
    
    class var orientationSize: CGSize {
        let systemVersion = Float(UIDevice.currentDevice().systemName)
        let isLand: Bool = UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation)
        return systemVersion > 8.0 && isLand ? UIScreen.SwapSize(self.size) : self.size
    }
    
    class var orientationWidth: CGFloat {
        return self.orientationSize.width
        
    }
    
    class var orientationHeight: CGFloat {
        return self.orientationSize.height
    }
    
    class var DPISize: CGSize {
        let size: CGSize = UIScreen.mainScreen().bounds.size
        let scale: CGFloat = UIScreen.mainScreen().scale
        return CGSize(width: size.width * scale, height: size.height * scale)
    }
    
    class func SwapSize(size: CGSize) -> CGSize {
        return CGSize(width: size.height, height: size.width)
    }
    
}