//
//  TSModel.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/7/26.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import ObjectMapper

typealias TSModelProtocol = ObjectMapper.Mappable
typealias TSMapper = ObjectMapper.Mapper

enum GenderType: Int {
    case Female = 0
    case Male
}


/**
 消息内容类型
 
 - Text:   文本
 - Image:  图片
 - Voice:  语音
 - System: 群组提示信息，例如:高必梵邀请白琳,彭莹加入群聊
 - File:   文件
 - Time:   时间 (客户端生成数据)
 */
enum MessageContentType: String {
    case Text = "0"
    case Image = "1"
    case Voice = "2"
    case System = "3"
    case File = "4"
    case Time = "110"
}


enum MessageFromType: String {
    case System = "0"
    case Personal = "1"
    case Group = "2"
    case PublicServer = "3"
    case PublicSubscribe = "4"
    
    var placeHolderImage: UIImage {
        switch self {
        case .Personal:
            return UIImage(asset: Asset.Icon_avatar)
        default:
            return UIImage(asset: Asset.Icon_avatar)
        
        }
    }
}














