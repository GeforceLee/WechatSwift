//
//  TSUIImageView+WeChat.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/7/29.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import Kingfisher

public extension UIImageView {
    func ts_setImageWithURLString(URLString: String?, placeholderImage placeholder: UIImage? = nil){
        guard let URLString = URLString, URL = NSURL(string: URLString) else{
            print("URL wrong")
            return
        }
        
        self.kf_setImageWithURL(URL, placeholderImage: placeholder)
    }
    
    func ts_setCircularImageWithURLString(URLString: String?, placeholderImage placeholder: UIImage? = nil){
        self.ts_setRoundImageWithURLString(URLString, placeholderImage: placeholder, cornerRadiusRatio: self.width / 2 )
    }
    
    func ts_setCornerRadiusImageWithURLString(URLString: String?, placeholderImage placeholder: UIImage? = nil, cornerRadiusRatio: CGFloat? = nil){
        self.ts_setRoundImageWithURLString(URLString,placeholderImage: placeholder, cornerRadiusRatio: cornerRadiusRatio)
    }
    
    
    
    func ts_setRoundImageWithURLString(URLString: String?, placeholderImage placeholder:UIImage? = nil ,cornerRadiusRatio: CGFloat? = nil, progressBlock: ImageDownloaderProgressBlock? = nil) {
        guard let URLString = URLString, URL = NSURL(string: URLString) else {
            print("URL wrong")
            return
        }
        
        let memoryImage = KingfisherManager.sharedManager.cache.retrieveImageInMemoryCacheForKey(URLString)
        let diskImage = KingfisherManager.sharedManager.cache.retrieveImageInDiskCacheForKey(URLString)
        
        guard let image = memoryImage ?? diskImage else {
            let optionInfo:KingfisherOptionsInfo = [
                .ForceRefresh,
            ]
            
            KingfisherManager.sharedManager.downloader.downloadImageWithURL(URL, options: optionInfo, progressBlock: progressBlock, completionHandler: { (image, error, imageURL, originalData) in
                if let image = image, originalData = originalData {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { 
                        let roundedImage = image.roundWithCornerRadius(image.size.width * (cornerRadiusRatio ?? 0.5))
                        
                        KingfisherManager.sharedManager.cache.storeImage(roundedImage, originalData: originalData, forKey: URLString, toDisk: true, completionHandler: { 
                            self.ts_setImageWithURLString(URLString)
                        })
                        
                    })
                }
            })
            return
        }
        self.image = image
    }
    
    
    
}


