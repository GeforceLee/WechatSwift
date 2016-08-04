//
//  ChatConfig.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/4.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation

public class ChatConfig {
    
    class func getThumbImageSize(originalSize: CGSize) -> CGSize {
        let imageRealHeight = originalSize.height
        let imageRealWidth = originalSize.width
        
        var resizeThumbWidth: CGFloat
        var resizeThumbHeight: CGFloat
        
        
        if imageRealHeight >= imageRealWidth {
            let scaleWidth = imageRealWidth * kChatImageMaxHeight / imageRealHeight
            resizeThumbWidth = (scaleWidth > kChatImageMaxWidth) ? scaleWidth : kChatImageMinWidth
            resizeThumbHeight = kChatImageMaxWidth
        } else {
            let scaleHeight = imageRealHeight * kChatImageMaxWidth / imageRealWidth
            resizeThumbHeight = (scaleHeight > kChatImageMinHeight) ? scaleHeight : kChatImageMinHeight
            resizeThumbWidth = kChatImageMaxWidth
        }
        

        return CGSizeMake(resizeThumbWidth, resizeThumbHeight)
        
    }
    
    
}