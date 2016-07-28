//
//  ChatModel.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/7/26.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//


import Foundation
import ObjectMapper
import YYText
class ChatModel: NSObject , TSModelProtocol{
    var audioModel: ChatAudioModel?
    var imageModel: ChatImageModel?
    var chatSendId: String?
    var chatReceiveId: String?
    var device: String?
    var messageContent: String?
    var messageId: String?
    var messageContentType: MessageContentType = .Text
    var timestamp :String?
    var messageFromType:MessageFromType = .Group
    
    var fromMe: Bool {return self.chatSendId == UserInstance.userId}
    var richTextLayout: YYTextLayout?
    var richTextLinePositionModifier: TSYYTextLinePositionModifier?
    var richTextAttributedString: NSMutableAttributedString?
    var messageSendSuccessType: MessageSendSuccessType = .Failed
    var cellHeight: CGFloat = 0
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        audioModel <- map["audioInfo"]
        chatSendId <- map["chat_cend_id"]
        device <- map["device"]
        messageContent <- map["message"]
        messageId <- map["message_id"]
        messageContentType <- (map["message_type"],EnumTransform<MessageContentType>())
        imageModel <- map["picInfo"]
        timestamp <- map["timestamp"]
        messageFromType <- (map["type"],EnumTransform<MessageFromType>())
    }
    
    init(timestamp: String) {
        super.init()
        self.timestamp = timestamp
        self.messageContent = self.timeDate.chatTimeString
        self.messageContentType = .Time
    }
    
    
    
    init(text: String) {
        super.init()
        self.timestamp = String(format: "%f", NSDate.milliseconds)
        self.messageContent = text
        self.messageContentType = .Text
        self.chatSendId = UserInstance.userId!
    }
    
    init(audioModel: ChatAudioModel) {
        super.init()
        self.timestamp = String(format: "%f", NSDate.milliseconds)
        self.messageContent = "[声音]"
        self.messageContentType = .Voice
        self.audioModel = audioModel
        self.chatSendId = UserInstance.userId!
    }
    
    
    init(imageModel: ChatImageModel) {
        super.init()
        self.timestamp = String(format: "%f", NSDate.milliseconds)
        self.messageContent = "[图片]"
        self.messageContentType = .Image
        self.imageModel = imageModel
        self.chatSendId = UserInstance.userId
    }
    
    
    override init() {
        super.init()
    }
    
}

extension ChatModel {
    func isLateForTowMinutes(targetModel: ChatModel) -> Bool {
        guard self.timestamp!.characters.count > 11 else {
            return false
        }
        
        guard targetModel.timestamp!.characters.count > 11 else {
            return false
        }
        
        let nextSeconds = Double(self.timestamp!)!/1000
        let perviousSeconds = Double(targetModel.timestamp!)!/1000
        return (nextSeconds - perviousSeconds) > 120
    }
    
    var timeDate:NSDate {
        get{
            let seconds = Double(self.timestamp!)!/1000
            let timeInterval: NSTimeInterval = NSTimeInterval(seconds)
            return NSDate(timeIntervalSince1970: timeInterval)
        }
    }
    
}


extension NSDate {
    private var chatTimeString: String {
        get{
            let calendar = NSCalendar.currentCalendar()
            let now = NSDate()
            let unit: NSCalendarUnit = [
                NSCalendarUnit.Minute,
                NSCalendarUnit.Hour,
                NSCalendarUnit.Day,
                NSCalendarUnit.Month,
                NSCalendarUnit.Year,
                ]
            let nowComponents:NSDateComponents = calendar.components(unit, fromDate: now)
            let targetComponents:NSDateComponents = calendar.components(unit, fromDate: self)
            
            let year = nowComponents.year - targetComponents.year
            let month = nowComponents.month - targetComponents.month
            let day = nowComponents.day - targetComponents.day
            
            if year != 0 {
                return String(format: "%zd年%zd月%zd日 %02d:%02d", targetComponents.year, targetComponents.month, targetComponents.day, targetComponents.hour, targetComponents.minute)
            } else {
                if (month > 0 || day > 7) {
                    return String(format: "%zd月%zd日 %02d:%02d", targetComponents.month, targetComponents.day, targetComponents.hour, targetComponents.minute)
                } else if (day > 2) {
                    return String(format: "%@ %02d:%02d",self.week(), targetComponents.hour, targetComponents.minute)
                } else if (day == 2) {
                    if targetComponents.hour < 12 {
                        return String(format: "前天上午 %02d:%02d",targetComponents.hour, targetComponents.minute)
                    } else if targetComponents.hour == 12 {
                        return String(format: "前天下午 %02d:%02d",targetComponents.hour, targetComponents.minute)
                    } else {
                        return String(format: "前天下午 %02d:%02d",targetComponents.hour - 12, targetComponents.minute)
                    }
                } else if (day == 1) {
                    if targetComponents.hour < 12 {
                        return String(format: "昨天上午 %02d:%02d",targetComponents.hour, targetComponents.minute)
                    } else if targetComponents.hour == 12 {
                        return String(format: "昨天下午 %02d:%02d",targetComponents.hour, targetComponents.minute)
                    } else {
                        return String(format: "昨天下午 %02d:%02d",targetComponents.hour - 12, targetComponents.minute)
                    }
                } else if (day == 0){
                    if targetComponents.hour < 12 {
                        return String(format: "上午 %02d:%02d",targetComponents.hour, targetComponents.minute)
                    } else if targetComponents.hour == 12 {
                        return String(format: "下午 %02d:%02d",targetComponents.hour, targetComponents.minute)
                    } else {
                        return String(format: "下午 %02d:%02d",targetComponents.hour - 12, targetComponents.minute)
                    }
                } else {
                    return ""
                }
            }
        }
    }
}






