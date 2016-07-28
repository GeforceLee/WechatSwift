//
//  TSYYTextLinePositionModifier.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/7/27.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation
import YYText

private let ascentScale: CGFloat = 0.84
private let descentScale: CGFloat = 0.16


class TSYYTextLinePositionModifier: NSObject, YYTextLinePositionModifier {
    internal var font:UIFont
    private var paddingTop: CGFloat = 2
    private var paddingBottom:CGFloat = 2
    private var lineHeightMultiple: CGFloat
    
    
    required init(font: UIFont) {
        if (UIDevice.currentDevice().systemVersion as NSString).floatValue >= 9.0 {
            self.lineHeightMultiple = 1.23
        } else {
            self.lineHeightMultiple =  1.1925
        }
        
        self.font = font
        super.init()
    }
    
    func modifyLines(lines: [YYTextLine], fromText text: NSAttributedString, inContainer container: YYTextContainer) {
        let ascent: CGFloat = self.font.pointSize * ascentScale
        let lineHeight: CGFloat = self.font.pointSize * self.lineHeightMultiple
        
        for line: YYTextLine in lines {
            var position: CGPoint = line.position
            position.y = self.paddingTop + ascent + CGFloat(line.row) * lineHeight
            line.position = position
        }
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        let one = self.dynamicType.init(font: self.font)
        return one
    }
    
    
    func heightForLineCount(lineCount: Int) ->CGFloat {
        if lineCount == 0 {
            return 0
        }
        
        
        let ascent: CGFloat = self.font.pointSize * ascentScale
        let descent: CGFloat = self.font.pointSize * descentScale
        let lineHeight: CGFloat = self.font.pointSize * self.lineHeightMultiple
        
        return self.paddingTop + self.paddingBottom + ascent + descent + CGFloat(lineCount - 1) * lineHeight
        
        
    }
    
    
}