//
//  UILabel+Extension.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/1.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation


extension UILabel {
    func contentSize() -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = self.lineBreakMode
        paragraphStyle.alignment = self.textAlignment
        let attributes: [String:  AnyObject] = [NSFontAttributeName: self.font, NSParagraphStyleAttributeName: paragraphStyle]
        let contentSize: CGSize = self.text!.boundingRectWithSize(self.frame.size,
                                                                  options: [.UsesLineFragmentOrigin,.UsesFontLeading],
                                                                  attributes: attributes,
                                                                  context: nil).size
        return contentSize
        
        
        
    }
    
    
    
    func setFromeWithString(string: String, width: CGFloat) {
        self.numberOfLines = 0
        let attributes: [String: AnyObject]  = [NSFontAttributeName: self.font]
        let resultSize: CGSize = string.boundingRectWithSize(CGSize(width: width,height: CGFloat.max),
                                                             options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                                                             attributes: attributes, context: nil).size
        
        let resultHeight: CGFloat = resultSize.height
        let resultWidth: CGFloat = resultSize.width
        var frame: CGRect = self.frame
        frame.size.height = resultHeight
        frame.size.width = resultWidth
        self.frame = frame
        
    }
}