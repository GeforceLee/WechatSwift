//
//  HttpManager+UploadImage.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/3.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import Alamofire

extension HttpManager {
    
    class func uploadSingleImage(image: UIImage,
                                 success:(imageModel: UploadImageModel) -> Void,
                                 failure:(Void) -> Void){
        let parameters = [
            "access_token" : UserInstance.accessToken
        ]
        
        let imageData = UIImageJPEGRepresentation(image, 0.7)
        
        let URLRequest = NSMutableURLRequest(URL: NSURL(string: "")!)
        
        Alamofire.upload(.POST, URLRequest, multipartFormData: { (multipartFormData) in
            if imageData != nil {
                multipartFormData.appendBodyPart(data: imageData!, name: "attach",fileName: "file", mimeType: "image/jpeg")
            }
            
            for (key, value) in parameters {
                multipartFormData.appendBodyPart(data: value!.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
            }
            }) { (result) in
                switch result {
                case .Success(let upload,_,_):
                    upload.responseFileUploadSwiftyJSON(completionHandler: { (response) in
                        switch response.result {
                        case .Success(let data):
                            let model: UploadImageModel = TSMapper<UploadImageModel>().map(data.dictionaryObject)!
                            success(imageModel: model)
                        case .Failure(_):
                            failure()
                        }
                    })
                case .Failure(let encodeingError):
                    debugPrint(encodeingError)
                }
        }
        
    }
    
    class func uploadMultipleImages(
        imagesArray:[UIImage],
        success: (imageModel: [UploadImageModel], imagesId: String) -> Void,
        failure: (Void) -> Void
        ) -> Void{
        guard imagesArray.count != 0 else {
            failure()
            return
        }
        
        
        for image in imagesArray {
            guard image.isKindOfClass(UIImage.self) else {
                failure()
                return
            }
        }
        
        let resultImageIdArray = NSMutableArray()
        let resultImageModelArray = NSMutableArray()
        
        let emptyId = ""
        for _ in 0..<imagesArray.count {
            resultImageIdArray.addObject(emptyId)
        }
        
        
        let group = dispatch_group_create()
        var index = 0
        for image in imagesArray {
            dispatch_group_enter(group)
            self.uploadSingleImage(image, success: { (imageModel) in
                let imageId = imageModel.imageId
                resultImageIdArray.replaceObjectAtIndex(index, withObject: imageId!)
                resultImageModelArray.addObject(imageModel)
                dispatch_group_leave(group)
                }, failure: {
                    dispatch_group_leave(group)
            })
            index += 1
        }
        
        
        dispatch_group_notify(group, dispatch_get_main_queue()) { 
            let checkIds = resultImageIdArray as NSArray as! [String]
            for imageId in checkIds {
                if imageId == emptyId {
                    failure()
                    return
                }
            }
            
            let ids = resultImageIdArray.componentsJoinedByString(",")
            let images = resultImageModelArray as NSArray as! [UploadImageModel]
            success(imageModel: images, imagesId: ids)
            
        }
        
        
        
    }
}