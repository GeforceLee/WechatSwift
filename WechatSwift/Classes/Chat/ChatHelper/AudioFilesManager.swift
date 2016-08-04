//
//  AudioFilesManager.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/4.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation

private let kAmrRecordFolder = "ChatAudioAmrRecord"
private let kWavRecordFolder = "ChatAudioWavRecord"

class AudioFilesManager {
    class func amrPathWithName(fileName: String) -> NSURL {
        let filePath = self.amrFilesFolder.URLByAppendingPathComponent("\(fileName).\(kAudioFileTypeAmr)")
        return filePath
    }
    
    class func warPathWithName(fileName: String) -> NSURL {
        let filePath = self.wavFilesFolder.URLByAppendingPathComponent("\(fileName).\(kAudioFileTypeWav)")
        return filePath
    }
    
    
    class func renameFile(originPath: NSURL, destinationPath: NSURL) -> Bool {
        do {
            try NSFileManager.defaultManager().moveItemAtPath(originPath.path!, toPath: destinationPath.path!)
            return true
        } catch let error as NSError {
            log.error("error:\(error)")
            return false
        }
    }
    
    class private func createAudioFolder(folderName: String) -> NSURL {
        let documentsDirectory = NSFileManager.defaultManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask)[0]
        let folder = documentsDirectory.URLByAppendingPathComponent(folderName)
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(folder.absoluteString){
            do {
                try fileManager.createDirectoryAtPath(folder.path!, withIntermediateDirectories: true, attributes: nil)
                return folder
            } catch let error as NSError {
                log.error("error:\(error)")
            }
        }
        return folder
    }
    
    private class var amrFilesFolder: NSURL {
        get {return self.createAudioFolder(kAmrRecordFolder)}
    }
        
    private class var wavFilesFolder: NSURL {
        get { return self.createAudioFolder(kWavRecordFolder)}
    }
    
    
    class func deleteAllRecordingFiles() {
        self.deleteFileWithPath(self.amrFilesFolder.path!)
        self.deleteFileWithPath(self.wavFilesFolder.path!)
    }
    
    private class func deleteFileWithPath(path: String) {
        let fileManager = NSFileManager.defaultManager()
        do {
            let files = try fileManager.contentsOfDirectoryAtPath(path)
            var recordings = files.filter({ (name) -> Bool in
                return name.hasSuffix(kAudioFileTypeWav)
            })
            
            for i in 0..<recordings.count {
                let path = path + "/" + recordings[i]
                log.info("removing \(path)")
                do {
                    try fileManager.removeItemAtPath(path)
                } catch let error as NSError{
                    log.info("could not remove \(path)")
                    log.info(error.localizedDescription)
                }
            }
        }catch let error as NSError {
            log.info("could not get contents of directory at \(path)")
            log.info(error.localizedDescription)
        }
    }
    
    
    
    
    
}
