//
//  PHAsset+Extension.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/2.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import Photos

extension PHAsset {
    func getUIImage() -> UIImage? {
        let manager = PHImageManager.defaultManager()
        let options = PHImageRequestOptions()
        options.synchronous = true
        options.networkAccessAllowed = true
        options.version = .Current
        options.deliveryMode = .HighQualityFormat
        options.resizeMode = .Exact
        
        
        
        var image: UIImage?
        manager.requestImageForAsset(self,
                                     targetSize: CGSize(width: self.pixelWidth,height: self.pixelHeight),
                                     contentMode: .AspectFill,
                                     options: options) { (result, info) in
                                        if let theResult = result {
                                            image = theResult
                                        } else {
                                            image = nil
                                        }
        }
        return image
    }
}