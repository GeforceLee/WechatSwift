//
//  ChatAudioModel.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/7/26.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import ObjectMapper

class ChatAudioModel: NSObject, TSModelProtocol {
    var audioId : String?
    var audioURL : String?
    var bitRate : String?
    var channels : String?
    var createTime: String?
    var duration : Float?
    var fileSize : String?
    var formatName : String?
    var keyHash : String?
    var mineType : String?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        audioId <- map["audio_id"]
        audioURL <- map["audio_url"]
        bitRate <- map["bit_rate"]
        channels <- map["channels"]
        createTime <- map["ctime"]
        duration <- (map["duration"],TransformerStringToFloat )
        fileSize <- map["file_size"]
        formatName <- map["format_name"]
        keyHash <- map["key_hash"]
        mineType <- map["mine_type"]
    }
    
}


class ChatImageModel: NSObject, TSModelProtocol {
    var imageHeight: CGFloat?
    var imageWidth: CGFloat?
    var imageId: String?
    var originalURL: String?
    var thumbURL: String?
    var localStoreName: String?
    var localThumbnailImage: UIImage? {
        if let theLocalStoreName = localStoreName{
            let path = ImageFilesManager.cachePathForKey(theLocalStoreName)
            return UIImage(contentsOfFile: path!)
        }else {
            return nil
        }
    }
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        imageHeight <- (map["height"],TransformerStringToCGFloat)
        imageWidth <- (map["width"],TransformerStringToCGFloat)
        originalURL <- map["original_url"]
        thumbURL <- map["thumb_url"]
        imageId <- map["image_id"]
        
    }
    
    
}




