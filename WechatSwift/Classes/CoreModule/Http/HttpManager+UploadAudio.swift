//
//  HttpManager+UploadAudio.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/3.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import Alamofire

extension HttpManager {
    class func uploadAudio(audioData: NSData,
                           recordTime: String,
                           success:(audioModel: UploadAudioModel) -> Void,
                           failure: (Void) -> Void
                           ) -> Void
    {
        let parameters = [
                "access_token" : UserInstance.accessToken,
                "record_time" : recordTime
        ]
        
        let URLRequest = NSMutableURLRequest(URL: NSURL(string: "")!)
        Alamofire.upload(.POST, URLRequest, multipartFormData: { (multipartFormData) in
            multipartFormData.appendBodyPart(data: audioData, name: "audio", fileName: "file", mimeType: "audio/AMR")
            for (key, value) in parameters {
                multipartFormData.appendBodyPart(data: value!.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
            }
            }) { (result) in
                switch  result {
                case .Success(let upload,_,_):
                    upload.responseFileUploadSwiftyJSON(completionHandler: { (response) in
                        log.info("response:\(response)")
                        switch response.result{
                        case .Success(let data):
                            let model: UploadAudioModel = TSMapper<UploadAudioModel>().map(data.dictionaryObject)!
                            success(audioModel: model)
                        case .Failure(_):
                            failure()
                        }
                    })
                case .Failure(let encodingError):
                    debugPrint(encodingError)
                }
                
        }
        
        
        
        
        
    }
    
    
}