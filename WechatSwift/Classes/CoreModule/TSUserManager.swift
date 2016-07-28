//
//  TSUserManager.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/7/27.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import KeychainAccess
import SwiftyJSON
let UserInstance = UserManager.sharedInstance
private let kNickname    = "kTS_wechat_username"
private let kAvatar      = "kTS_wechat_avatar"
private let kAccessToken = "kTS_wechat_accessToken"
private let kUserId      = "kTS_wechat_userId"
private let kIsLogin     = "kTS_wechat_isLogin"
private let kLoginName   = "kTS_wechat_loginName"
private let kPassword    = "kTS_wechat_password"

class UserManager: NSObject {
    class var sharedInstance: UserManager {
        struct Static {
            static let instance: UserManager = UserManager()
        }
        
        return Static.instance
    }
    
    
    let TSKeyChain = Keychain(service: "com.wechat.Hilen")
    var accessToken: String? {
        get {return TSUserDefaults.getString(kAccessToken, defaultValue: "token")}
    }
    
    
    var userId: String?
        
    
}