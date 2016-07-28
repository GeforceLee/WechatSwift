//
//  TSModelTransformer.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/7/26.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import ObjectMapper

/// 转换器: 把1423094023323 微秒时间转换成 几天前，几小时前
let TransformerTimestampToTimeAgo = TransformOf<String,NSNumber>(fromJSON: {(value: AnyObject?) -> String? in
    guard let value = value else {
        return ""
    }
    
    let seconds = Double(value as! NSNumber)/1000
    let timeInterval: NSTimeInterval = NSTimeInterval(seconds)
    let date = NSDate(timeIntervalSince1970: timeInterval)
    let string = NSDate.messageAgoSinceDate(date)
    return string
    
    }, toJSON: {(value: String?) -> NSNumber? in
        return nil
})
/// 把字符串转换为float
let TransformerStringToFloat = TransformOf<Float, String>(fromJSON: { (value: String?) -> Float? in
    guard let value = value else {
        return 0
    }
    
    let intValue: Float? = Float(value)
    return intValue
    }, toJSON: {(value: Float?) -> String? in
        if let vaule = value {
            return String(value)
        }
        return nil
    }
)

/// 把字符串转换为Int
let TransformerStringToInt = TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in
    guard let value = value else {
        return 0
    }
    let intValue: Int? = Int(value)
    return intValue
    }, toJSON: { (value: Int?) -> String? in
        if let value = value {
            return String(value)
        }
        return nil
})


let TransformerStringToCGFloat = TransformOf<CGFloat, String>(fromJSON: { (value:String?) -> CGFloat? in
    guard let value = value else {
        return nil
    }
    let intValue: CGFloat? = CGFloat(Float(value)!)
    return intValue
    }, toJSON: {(value: CGFloat?) -> String? in
        if let value = value {
            return String(value)
        }
        return nil
})



let TRansformerArrayToLocation = TransformOf<CLLocation, [Double]>(fromJSON:{(value: [Double]?) -> CLLocation? in
    if let coordList = value where coordList.count == 2{
        return CLLocation(latitude: coordList[1], longitude: coordList[0])
    }
    return nil
    },toJSON:{(value: CLLocation?) -> [Double]? in
        if let location = value {
            return [Double(location.coordinate.longitude),Double(location.coordinate.latitude)]
        }
        return nil
})















