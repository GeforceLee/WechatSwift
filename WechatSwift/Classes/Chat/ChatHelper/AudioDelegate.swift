//
//  AudioDelegate.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/4.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation

protocol RecordAudioDeledate: class {
    
    func audioRecordUpdateMetra(metra: Float)
    
    func audioRecordTooShort()
    
    func audioRecordFailed()
    
    func audioRecoredCanceled()
    
    
    func audioRecordFinish(uploadAmrData: NSData, recordTime: Float, fileHash: String)
    
}


protocol PlayAudioDelegate: class {
    
    func audioPlayStart()
    
    func audioPlayFinish()
    
    func audioPlayFailed()
    
    func audioPlayInterruption()
    
}