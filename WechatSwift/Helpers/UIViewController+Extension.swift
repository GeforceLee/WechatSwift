//
//  UIViewController+Extension.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/2.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation

extension UIViewController {
    
    class func initFromNib() -> UIViewController {
        let hasNib: Bool = NSBundle.mainBundle().pathForResource(self.nameOfClass, ofType: "nib") != nil
        guard hasNib else {
            assert(!hasNib, "")
            return UIViewController()
        }
        
        return self.init(nibName: self.nameOfClass, bundle: nil)
    }
    
    public static var topViewController: UIViewController? {
        var presentedVC = UIApplication.sharedApplication().keyWindow?.rootViewController
        
        while let pVC = presentedVC?.presentedViewController {
            presentedVC = pVC
        }
        
        if presentedVC == nil {
            print("Error")
        }
        return presentedVC
        
    }
    
    
    private  func ts_pushViewController(viewController: UIViewController, animated: Bool, hideTabbar: Bool) {
        viewController.hidesBottomBarWhenPushed = hideTabbar
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    
    public func ts_pushAndHideTabbar(viewController: UIViewController) {
        self.ts_pushViewController(viewController, animated: true, hideTabbar: true)
    }
    
    public func ts_presentViewController(viewController: UIViewController, completion: (() -> Void)? ){
        let navigationController = UINavigationController(rootViewController: viewController)
        self.presentViewController(navigationController, animated: true, completion: completion)
    }
    
    
}
