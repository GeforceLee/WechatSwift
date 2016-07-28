//
//  TSMessageModel.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/7/27.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import ObjectMapper

class MessageModel: NSObject, TSModelProtocol {
    var middleImageURL: String?
    var unreadNumber: Int?
    var nickname: String?
    var messageFromType: MessageFromType = MessageFromType.Personal
    var messageContentType: MessageContentType = MessageContentType.Text
    var chatId: String?
    var latestMessage: String?
    var dateString: String?
    
    required init?(_ map:Map) {
        
    }
    
    func mapping(map: Map) {
        middleImageURL <- map["avatar_url"]
        unreadNumber <- map["message_unread_num"]
        nickname <- map["nickname"]
        messageFromType <- (map["message_from_type"],EnumTransform<MessageFromType>())
        chatId <- map["userid"]
        latestMessage <- map["last_message.message"]
        messageContentType <- (map["last_message.message_content_type"],EnumTransform<MessageContentType>())
        dateString <- (map["last_message.timestamp"],TransformerTimestampToTimeAgo)
    }
    
    
    var lastMessage: String? {get{
        switch self.messageContentType {
        case .Text, .System:
            return self.lastMessage
        case .Image:
            return "[图片]"
        case .Voice:
            return "[语音]"
        case .File:
            return "文件"
        default:
            return ""
        }
        }
        
    }
    
}