//
//  TSResponseSerializer.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/3.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


private let kKeyMessage = "message"
private let kKeyData = "data"
private let kKeyCode = "code"



extension Request {
    public func responseFileUploadSwiftyJSON(options: NSJSONReadingOptions = .AllowFragments, completionHandler: Response<JSON, NSError> -> Void) -> Self {
        return response(responseSerializer: Request.fileUploadSwiftyJSONResponseSerializer(options), completionHandler: completionHandler)
    }
    
    
    public static func fileUploadSwiftyJSONResponseSerializer(options: NSJSONReadingOptions = .AllowFragments) -> ResponseSerializer<JSON, NSError> {
        return ResponseSerializer(serializeResponse: { (_, _, data, error)  in
            guard error == nil else {
                log.error("error:\(error)")
                let failureReason = "网络不给力啊"
                let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                return .Failure(error)
            }
            
            guard let validData = data where validData.length > 0 else {
                let failureReason = "数据错误"
                let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                return .Failure(error)
            }
            
            let json: JSON = SwiftyJSON.JSON(data:  validData)
            if let jsonError = json.error{
                return Result.Failure(jsonError)
            }
            
            let code = json[kKeyCode].intValue
            if code == 1993 {
                let error = Error.errorWithCode(code, failureReason: json["message"].stringValue)
                return .Failure(error)
            }
            
            return Result.Success(json)
        })
    }
    
}