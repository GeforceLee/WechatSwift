//
//  TSProgressHUD.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/7/28.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import SVProgressHUD


class TSProgressHUD: NSObject {
    class func ts_initHUD() {
        SVProgressHUD.setBackgroundColor(UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.7))
        SVProgressHUD.setForegroundColor(UIColor.whiteColor())
        SVProgressHUD.setFont(UIFont.systemFontOfSize(14))
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.None)
    }
    
    
    class func ts_showSuccessWithStatus(string: String){
        self.TSProgressHUDShow(.Success, status:  string)
    }
    
    class func ts_showErrorWithObject(error: NSError) {
        self.TSProgressHUDShow(.ErrorObject, status: nil,error:  error)
    }

    class func ts_showErrorWithStatus(string: String){
        self.TSProgressHUDShow(.ErrorString, status:  string)
    }
    
    class func ts_showWithStatus(string: String){
        self.TSProgressHUDShow(.Loading, status:  string)
    }
    
    
    class func ts_showWarningWithStatus(string: String){
        self.TSProgressHUDShow(.Info, status:  string)
    }
    
    class func ts_dismiss() {
        SVProgressHUD.dismiss()
    }
    
    
    
    private class func TSProgressHUDShow(type: HUDType, status: String? = nil, error: NSError? = nil){
        switch type {
        case .Success:
            SVProgressHUD.showSuccessWithStatus(status)
            break
        case .ErrorObject:
            guard let newError = error else {
                SVProgressHUD.showErrorWithStatus("Error:出错了")
                return
            }
            if newError.localizedFailureReason == nil {
                SVProgressHUD.showErrorWithStatus("Error:出错了")
            } else {
                SVProgressHUD.showErrorWithStatus(newError.localizedFailureReason)
            }
            break
        case .ErrorString:
            SVProgressHUD.showErrorWithStatus(status)
            break;
        case .Info:
            SVProgressHUD.showInfoWithStatus(status)
            break;
        case .Loading:
            SVProgressHUD.showWithStatus(status)
        }
    }
    
    
    
    private enum HUDType: Int {
        case Success, ErrorObject, ErrorString, Info, Loading
    }
    
}