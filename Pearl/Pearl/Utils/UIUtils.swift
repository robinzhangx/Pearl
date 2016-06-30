//
//  UIUtils.swift
//  Pearl
//
//  Created by robin on 6/26/16.
//  Copyright © 2016 robiz.co. All rights reserved.
//

import Foundation
import UIKit

class UIUtils {
    class func imageWithColor(color: UIColor, size: CGFloat) -> UIImage {
        let rect = CGRectMake(0, 0, size, size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func createBackgroundImage(color: UIColor, corners: UIRectCorner, cornerRadius r: CGFloat) -> UIImage {
        let rect = CGRectMake(0, 0, r * 2 + 1, r * 2 + 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.mainScreen().scale)
        let ctx = UIGraphicsGetCurrentContext()
        UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSizeMake(r, r)).addClip()
        CGContextSetFillColorWithColor(ctx, color.CGColor)
        CGContextFillRect(ctx, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image.resizableImageWithCapInsets(UIEdgeInsets(top: r, left: r, bottom: r, right: r))
    }
    
    class func createBackgroundImage(borderColor: UIColor, borderWidth w: CGFloat, corners: UIRectCorner, cornerRadius r: CGFloat) -> UIImage {
        let rect = CGRectMake(0, 0, r * 2 + w + 1, r * 2 + w + 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.mainScreen().scale)
        let ctx = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: CGRectMake(w / 2 , w / 2, r * 2 + 1, r * 2 + 1),
                                byRoundingCorners: corners, cornerRadii: CGSizeMake(r, r))
        CGContextSetStrokeColorWithColor(ctx, borderColor.CGColor)
        CGContextSetLineWidth(ctx, w)
        CGContextAddPath(ctx, path.CGPath)
        CGContextStrokePath(ctx)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image.resizableImageWithCapInsets(UIEdgeInsets(top: r + w / 2, left: r + w / 2, bottom: r + w / 2, right: r + w / 2))
    }
}