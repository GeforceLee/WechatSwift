//
//  NSDictionary+Extension.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/1.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation

public extension Dictionary {
    mutating func merge<K,V>(dictionaries: Dictionary<K,V>...) {
        for dict in dictionaries {
            for (key,value) in dict{
                self.updateValue(value as! Value, forKey: key as! Key)
            }
        }
    }
    
    
    func combine(targetDictionary: Dictionary<String, AnyObject>, resultDictionary: Dictionary<String, AnyObject>) -> Dictionary<String, AnyObject> {
        var temp = resultDictionary
        for (key, value) in targetDictionary {
            temp[key] = value
        }
        return temp
    }
}


public func + <K, V>(left: Dictionary<K, V>, right: Dictionary<K, V>) -> Dictionary<K, V> {
    var map = Dictionary<K, V>()
    for (k, v) in left {
        map[k] = v
    }
    for (k, v) in right {
        map[k] = v
    }
    return map
}

