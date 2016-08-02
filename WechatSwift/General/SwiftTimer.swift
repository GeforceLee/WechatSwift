//
//  SwiftTimer.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/1.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation

private class NSTimerActor {
    let block: () -> Void
    init(_ block: () ->Void) {
        self.block = block
    }
    
    
    
    @objc func fire() {
        block()
    }
}


extension NSTimer {
    public class func new(after interval: NSTimeInterval, _ block: ()-> Void ) -> NSTimer {
        let actor = NSTimerActor(block)
        return self.init(timeInterval: interval, target: actor, selector:  #selector(NSTimerActor.fire),userInfo:  nil, repeats: true)
    }
    
    
    public class func new(every interval: NSTimeInterval, _ block: () -> Void) -> NSTimer {
        let actor = NSTimerActor(block)
        return self.init(timeInterval: interval, target:  actor, selector:  #selector(NSTimerActor.fire), userInfo:  nil, repeats:  true)
    }
    
    public class func after(interval: NSTimeInterval, _ block: () -> Void) -> NSTimer {
        let timer = NSTimer.new(after: interval, block)
        timer.start()
        return timer
    }
    
    
    public class func every(interval: NSTimeInterval, _ block: () -> Void) -> NSTimer {
        let timer = NSTimer.new(every: interval, block)
        timer.start()
        return timer
    }
    
    public func start(runLoop runLoop: NSRunLoop = NSRunLoop.currentRunLoop(), modes: String...)
    {
        let modes = modes.isEmpty ? [ NSDefaultRunLoopMode] : modes
        
        for mode in modes {
            runLoop.addTimer(self, forMode: mode)
        }
    }
    
}

extension Double {
    public var ms: NSTimeInterval{ return self / 1000 }
    public var second: NSTimeInterval{  return self }
    public var seconds: NSTimeInterval{  return self }
    public var mintue: NSTimeInterval{ return self * 60 }
    public var minutes: NSTimeInterval {return self * 60}
    public var hour: NSTimeInterval {return self * 3600}
    public var hours: NSTimeInterval {return self * 3600}
}
















