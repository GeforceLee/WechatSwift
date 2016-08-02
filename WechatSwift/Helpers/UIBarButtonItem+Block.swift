//
//  UIBarButtonItem+Block.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/2.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation

public typealias ActionHandler = (Void) -> Void

public extension UIViewController {
    
    func leftBackAction(action: ActionHandler) -> Void {
        self.leftBackBarButton(Asset.Back_icon.image, action: action)
    }
    
    
    func leftBackToPrevious() {
        self.leftBackBarButton(Asset.Back_icon.image, action: nil)
    }
    
    
    private func leftBackBarButton(backImage: UIImage, action: ActionHandler?){
        guard self.navigationController != nil else {
            assert(false,"")
            return
        }
        
        
        let button: UIButton = UIButton(type: UIButtonType.Custom)
        button.setImage(backImage, forState: .Normal)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        button.imageView?.contentMode = .ScaleAspectFit
        button.contentHorizontalAlignment = .Left
        
        button.ngl_addAction(forControlEvents: .TouchUpInside) { [weak self] in
            if action != nil {
                action!()
                return
            }
            
            if self!.navigationController!.viewControllers.count > 1 {
                self?.navigationController?.popViewControllerAnimated(true)
            } else if (self?.presentedViewController != nil ){
                self?.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        let barButton = UIBarButtonItem(customView: button)
        let gapItem = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        gapItem.width = -7
        self.navigationItem.leftBarButtonItems = [gapItem,barButton]
        
    }
    
}


public extension UINavigationItem {
    func leftButtonAction(image: UIImage, action:ActionHandler) {
        let button: UIButton = UIButton(type: UIButtonType.Custom)
        button.setImage(image, forState: .Normal)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        button.imageView?.contentMode = .ScaleAspectFit
        button.contentHorizontalAlignment = .Right
        button.ngl_addAction(forControlEvents: .TouchUpInside){
            action()
        }
        
        let barButton = UIBarButtonItem(customView: button)
        let gapItem = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        gapItem.width = -7
        self.leftBarButtonItems = [gapItem, barButton]
    }
    
    
    func rightButtonAction(image: UIImage, action: ActionHandler) -> Void {
        let button: UIButton = UIButton(type: UIButtonType.Custom)
        button.setImage(image, forState: .Normal)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        button.imageView?.contentMode = .ScaleAspectFit
        button.contentHorizontalAlignment = .Right
        button.ngl_addAction(forControlEvents: .TouchUpInside) {
            action()
        }
        let barButton = UIBarButtonItem(customView: button)
        let gapItem = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        gapItem.width = -7
        self.rightBarButtonItems = [gapItem, barButton]
        
        
    }
}



public class ClosureWrapper: NSObject {
    let _callback: Void -> Void
    init(callback: Void -> Void) {
        _callback = callback
    }
    
    
    
    public func invoke() {
        _callback()
    }
}

var AssociatedClosure: UInt8 = 0

extension UIControl {
    private func ngl_addAction(forControlEvents events: UIControlEvents, withCallback callback: Void -> Void) {
        let wrapper = ClosureWrapper(callback: callback)
        addTarget(wrapper, action: #selector(ClosureWrapper.invoke), forControlEvents: events)
        objc_setAssociatedObject(self, &AssociatedClosure, wrapper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
    }
}