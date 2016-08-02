//
//  TSImagePicker.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/1.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import BSImagePicker
import Photos

public extension UIViewController {
    func ts_presentImagePickerController(maxNumberOfSelections maxNumberOfSelections: Int, select:((asset: PHAsset) -> Void)?, deselect: ((asset: PHAsset) ->Void)?,cancel: (([PHAsset]) -> Void)?,finish: (([PHAsset]) -> Void)?, completion: (() -> Void)?) {
        
        let viewController = BSImagePickerViewController()
        viewController.maxNumberOfSelections = maxNumberOfSelections
        viewController.albumButton.tintColor = UIColor.whiteColor()
        viewController.cancelButton.tintColor = UIColor.whiteColor()
        viewController.doneButton.tintColor = UIColor.whiteColor()
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: false)
        self.bs_presentImagePickerController(viewController, animated: true, select: select, deselect: deselect, cancel: cancel, finish: finish) { 
            TSApplicationManager.initNavigationBar()
            if let newCompletion = completion {
                newCompletion()
            }
        }
        
    }
}