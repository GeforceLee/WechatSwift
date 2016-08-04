//
//  AudioRecordManager.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/4.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import AVFoundation
import TSVoiceConverter



let kAudioFileTypeWav = "wav"
let kAudioFileTypeAmr = "amr"
let AudioRecordInstance = AudioRecordManager.sharedInstance

private let TempWavRecordPath = AudioFilesManager.amrPathWithName("wav_temp_record")
private let TempAmrRecordPath = AudioFilesManager.warPathWithName("amr_temp_record")



class AudioRecordManager: NSObject {
    var recorder: AVAudioRecorder!
    var operationQueue: NSOperationQueue!
    weak var delegate: RecordAudioDeledate?
    
    private var startTime: CFTimeInterval!
    private var endTime:  CFTimeInterval!
    private var audioTimeInterval: NSNumber!
    private var isFinishRecord: Bool = true
    private var isCancelRecord: Bool = false
    
    
    class var sharedInstance: AudioRecordManager {
        struct Static {
            static let instance: AudioRecordManager = AudioRecordManager()
        }
        return Static.instance
    }
    
    
    private override init() {
        self.operationQueue = NSOperationQueue()
        super.init()
    }
    
    func checkPermissionAndSetupRecord() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: .DuckOthers)
            do {
                try session.setActive(true)
                session.requestRecordPermission({ (allowed) in
                    if !allowed {
                        TSAlertView_show("无法访问您的麦克风",message: "请到设置 -> 隐私 -> 麦克风 ，打开访问权限")
                    }
                })
            } catch let error as NSError {
                log.error("\(error)")
            }
        }catch let error as NSError {
            log.error("\(error)")
        }
    }
    
    
    func checkHeadphones() {
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        if  currentRoute.outputs.count > 0 {
            for description in currentRoute.outputs {
                if description.portType == AVAudioSessionPortHeadphones {
                    log.info("headphones are plugged in ")
                    break
                }else {
                    log.info("")
                }
            }
        }else {
            log.info("checking headphones requires a connection to a device")
        }
        
    }
    
    
    func startRecord() {
        self.isCancelRecord = false
        self.startTime = CACurrentMediaTime()
        do {
            let recordSettings: [String: AnyObject] = [
                AVLinearPCMIsFloatKey: NSNumber(int: 16),
                AVFormatIDKey: NSNumber(unsignedInt: kAudioFormatLinearPCM),
                AVNumberOfChannelsKey: NSNumber(int: 1),
                AVSampleRateKey: NSNumber(float: 8000.0)
            ]
            
            self.recorder = try AVAudioRecorder(URL: TempWavRecordPath, settings: recordSettings)
            self.recorder.delegate = self
            self.recorder.meteringEnabled = true
            self.recorder.prepareToRecord()
            
        }catch let error as NSError {
            self.recorder = nil
            log.error("\(error)")
        }
        self.performSelector(#selector(AudioRecordManager.readyStartRecord),withObject:nil, afterDelay:  0.0)
        
        
    }
    
    
    func  readyStartRecord() -> Void {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
        } catch let error as NSError {
            log.error("\(error)")
            return
        }
        
        
        do {
            try audioSession.setActive(true)
        } catch let error as NSError {
            log.error("\(error)")
            return
        }
        
        self.recorder.record()
        let operation = NSBlockOperation()
        operation.addExecutionBlock(updateMeters)
        self.operationQueue.addOperation(operation)
        
    }
    
    func updateMeters(){
        guard let recorder = self.recorder else {return}
        
        repeat {
            recorder.updateMeters()
            self.audioTimeInterval =  NSNumber(float: NSNumber(double: recorder.currentTime).floatValue)
            let averagePower = recorder.averagePowerForChannel(0)
            let lowPassResults = pow(10, 0.05 * averagePower) * 10
            dispatch_async_safely_to_main_queue({ 
                self.delegate?.audioRecordUpdateMetra(lowPassResults)
            })
            
            
            if self.audioTimeInterval.intValue > 60 {
                self.stopRecord()
            }
            
            NSThread.sleepForTimeInterval(0.05)
            
        }while recorder.recording
            
        
    }
    
    
    
    func stopRecord() {
        self.isFinishRecord = true
        self.isCancelRecord = false
        self.endTime = CACurrentMediaTime()
        if (self.endTime - self.startTime) < 0.5 {
            NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: #selector(AudioRecordManager.readyStartRecord), object: self)
            dispatch_async_safely_to_main_queue({ 
                self.delegate?.audioRecordTooShort()
            })
        } else {
            self.audioTimeInterval = NSNumber(int: NSNumber(double: self.recorder.currentTime).intValue)
            if  self.audioTimeInterval.intValue < 1 {
                self.performSelector(#selector(AudioRecordManager.readyStartRecord), withObject:  self, afterDelay:  0.4)
            }else{
                self.readyStartRecord()
            }
        }
        
        self.operationQueue.cancelAllOperations()
    }
    
    
    
    func cancelRecord() {
        self.isCancelRecord = true
        NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: #selector(AudioRecordManager.readyStartRecord), object: self)
        self.isFinishRecord = false
        self.recorder.stop()
        self.recorder.deleteRecording()
        self.recorder = nil
        self.delegate?.audioRecoredCanceled()
    }
    
    func readyStopRecord() {
        self.recorder.stop()
        self.recorder = nil
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false, withOptions: .NotifyOthersOnDeactivation)
        } catch let error as NSError {
            log.error("\(error)")
        }
        
    }
    
    
    func deleteRecordFiles() {
        AudioFilesManager.deleteAllRecordingFiles()
    }
    
}


extension AudioRecordManager : AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag && self.isFinishRecord {
            if TSVoiceConverter.convertWavToAmr(TempWavRecordPath.path!, amrSavePath: TempAmrRecordPath.path!) {
                guard let  amrAudioData = NSData(contentsOfURL: TempAmrRecordPath) else {
                    self.delegate?.audioRecordFailed()
                    return
                }
                let fileName = amrAudioData.MD5String
                let amrDestionationURL = AudioFilesManager.amrPathWithName(fileName)
                log.warning("amr destination URL:\(amrDestionationURL)")
                AudioFilesManager.renameFile(TempAmrRecordPath, destinationPath: amrDestionationURL)
                
                let wavDestinationURL = AudioFilesManager.warPathWithName(fileName)
                AudioFilesManager.renameFile(TempWavRecordPath, destinationPath: wavDestinationURL)
                self.delegate?.audioRecordFinish(amrAudioData, recordTime: self.audioTimeInterval.floatValue, fileHash: fileName)
                
            } else {
                if !self.isCancelRecord {
                    self.delegate?.audioRecordFailed()
                    
                }
            }
        }
    }
    
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder, error: NSError?) {
        if let  e = error {
            log.error("\(e)")
            self.delegate?.audioRecordFailed()
        }
    }
    
    
}









