//
//  String+Extenstion.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/2.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation

extension String {
    func stringHeightWithMaxWidth(maxWidth: CGFloat, font: UIFont) -> CGFloat {
        let attributes: [String: AnyObject] = [
            NSFontAttributeName: font
        ]
        
        
        let size:CGSize = self.boundingRectWithSize(CGSize(width: maxWidth, height: CGFloat.max),
                                                    options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                                                    attributes: attributes,
                                                    context: nil).size
        return size.height
    }
}