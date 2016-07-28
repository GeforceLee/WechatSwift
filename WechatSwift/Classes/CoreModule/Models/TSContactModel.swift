//
//  TSContactModel.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/7/27.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import ObjectMapper
@objc class ContactModel: NSObject,TSModelProtocol {
    var avatarSmallURL: String?
    var chineseName: String?
    var nameSpell: String?
    var phone: String?
    var userId: String?
    
    override init(){
        super.init()
    }
    
    required init?(_ map:Map){
        
    }
    
    
    func mapping(map: Map) {
        avatarSmallURL <- map["avatar_url"]
        chineseName <- map["name"]
        nameSpell <- map["name_spell"]
        phone <- map["phone"]
        userId <- map["userid"]
    }
    
    
    func compareContct(contactModel: ContactModel) -> NSComparisonResult {
        let result = self.nameSpell?.compare(contactModel.nameSpell!)
        return result!
    }
    
}


enum ContactModelEnum: Int {
    case NewFriends = 0
    case PublicAccout
    case GroupChat
    case Tags
    
    var model: ContactModel {
        let model = ContactModel()
        switch (self) {
        case .GroupChat:
            model.chineseName = "群聊"
            model.avatarSmallURL = "http://ww1.sinaimg.cn/large/6a011e49jw1f18hercci7j2030030glf.jpg"
            return model
        case .PublicAccout:
            model.chineseName = "公众号"
            model.avatarSmallURL = "http://ww2.sinaimg.cn/large/6a011e49jw1f18hkv6i5kj20300303yb.jpg"
            return model
        case .NewFriends:
            model.chineseName = "新的朋友"
            model.avatarSmallURL = "http://ww4.sinaimg.cn/large/6a011e49jw1f18hftp0foj2030030dfn.jpg"
            return model
        case .Tags:
            model.chineseName = "标签"
            model.avatarSmallURL = "http://ww2.sinaimg.cn/large/6a011e49jw1f18hh48jr3j2030030743.jpg"
            return model
        }
    }
}



