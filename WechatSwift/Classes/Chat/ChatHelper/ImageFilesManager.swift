//
//  ImageFilesManager.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/7/27.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import Kingfisher

class ImageFilesManager {
    let imageCacheFolder = KingfisherManager.sharedManager.cache
    
    class func cachePathForKey(key: String) -> String? {
        let fileName = key.MD5String
        return (KingfisherManager.sharedManager.cache.diskCachePath as NSString).stringByAppendingPathComponent(fileName)
    }
    
    
    class func storeImage(image: UIImage, key: String, completionHandler: (() -> ())?){
        KingfisherManager.sharedManager.cache.removeImageForKey(key)
        KingfisherManager.sharedManager.cache.storeImage(image, forKey: key, toDisk: true, completionHandler: completionHandler)
    }
    
    
    class func renameFile(originPath: NSURL, destinationPath: NSURL) ->Bool {
        do {
            try NSFileManager.defaultManager().moveItemAtPath(originPath.path!, toPath: destinationPath.path!)
            return true
        } catch let error as NSError {
            log.error("error:\(error)")
            return false
        }
    }
    
}