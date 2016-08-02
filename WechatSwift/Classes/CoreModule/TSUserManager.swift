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
        set(newValue) {TSUserDefaults.setString(kAccessToken, value: newValue)}
    }
    
        
    var nickname: String? {
        get {return TSUserDefaults.getString(kNickname,defaultValue: "")}
        set(newValue){TSUserDefaults.setString(kNickname, value: newValue)}
    }
    
    var avatar: String?
    
    var userId: String?{
        get{return TSUserDefaults.getString(kUserId, defaultValue: TSConfig.testUserID)}
        set(newValue){TSUserDefaults.setString(kUserId, value: newValue)}
    }
    
    
    var isLogin: Bool {
        get {return TSUserDefaults.getBool(kIsLogin, defaultValue:  false)}
        set(newValue){ TSUserDefaults.setBool(kIsLogin, value: newValue)}
    }
    
    var loginName: String? {
        get {return TSKeyChain[kLoginName] ?? ""}
        set(newValue){TSKeyChain[kLoginName] = newValue}
    }
    
    var password: String? {
        get {return TSKeyChain[kPassword] ?? ""}
        set(newValue){ TSKeyChain[kPassword] = newValue}
    }
    
    private override init() {
        super.init()
    }
    
    
    func readAllData() {
        self.nickname = TSUserDefaults.getString(kNickname, defaultValue: "")
         self.avatar = TSUserDefaults.getString(kAvatar, defaultValue: "")
        self.userId = TSUserDefaults.getString(kUserId, defaultValue: "")
        self.isLogin = TSUserDefaults.getBool(kIsLogin,defaultValue: false)
        self.loginName = TSKeyChain[kIsLogin] ?? ""
        self.password = TSKeyChain[kPassword] ?? ""
    
    }
    
    func userLoginSuccess(result: JSON) -> Void{
        self.loginName = result["username"].stringValue
        self.password = result["password"].stringValue
        self.nickname = result["nickname"].stringValue
        self.userId = result["user_id"].stringValue
        self.isLogin = true
    }
    
    func userLogout() {
        self.accessToken = ""
        self.loginName = ""
        self.password = ""
        self.nickname = ""
        self.userId = ""
        self.isLogin = false
    }
    
    func resetAccessToken(token: String) {
        TSUserDefaults.setString(kAccessToken, value: token)
        if token.characters.count > 0 {
            print("token success")
        } else {
            self.userLogout()
        }
    }
    
}


















