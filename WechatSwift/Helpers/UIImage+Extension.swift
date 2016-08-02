//
//  UIImage+Extension.swift
//  WechatSwift
//
//  Created by Yunlong Li on 16/8/2.
//  Copyright © 2016年 GlobalTravel. All rights reserved.
//

import Foundation

public extension UIImage {
    public enum UIImageContentMode {
        case ScaleToFill, ScaleAspectFit, ScaleAspectFill
    }
    
    func resize(size: CGSize, contentMode: UIImageContentMode = .ScaleToFill, quality: CGInterpolationQuality = .Medium) -> UIImage? {
        let horizontalRatio = size.width / self.size.width
        let verticalRatio = size.height / self.size.height
        var ratio: CGFloat!
        
        switch contentMode {
        case .ScaleToFill:
            ratio = 1
        case .ScaleAspectFill:
            ratio = max(horizontalRatio, verticalRatio)
        case .ScaleAspectFit:
            ratio = min(horizontalRatio, verticalRatio)
            
        }
        let rect = CGRect(x: 0, y: 0, width: size.width * ratio, height: size.height * ratio)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
        let context = CGBitmapContextCreate(nil, Int(rect.size.width), Int(rect.size.height), 8, 0, colorSpace, bitmapInfo.rawValue)
        
        let transform = CGAffineTransformIdentity
        
        CGContextConcatCTM(context, transform)
        
        CGContextSetInterpolationQuality(context, quality)
        
        
        CGContextDrawImage(context, rect, self.CGImage)
        
        let newImage = UIImage(CGImage: CGBitmapContextCreateImage(context)!, scale: self.scale, orientation: self.imageOrientation)
        return newImage
        
    }
    
    
    func screenCaptureWithView(view: UIView, rect: CGRect) -> UIImage {
        var capture: UIImage
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1.0)
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y)
        
        if view.respondsToSelector(#selector(UIView.drawViewHierarchyInRect(_:afterScreenUpdates:))) {
            view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        }else {
            view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        }
        capture = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return capture
    }
    
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    func roundWithCornerRadius(cornerRadius: CGFloat) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0,y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        drawInRect(rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    
    func hasAlpha() -> Bool {
        let alpha: CGImageAlphaInfo = CGImageGetAlphaInfo(self.CGImage)
        return (alpha == .First || alpha == .Last || alpha == .PremultipliedFirst || alpha == .PremultipliedLast)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}