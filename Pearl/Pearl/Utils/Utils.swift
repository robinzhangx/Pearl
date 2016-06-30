//
//  Utils.swift
//  Pearl
//
//  Created by robin on 6/26/16.
//  Copyright © 2016 robiz.co. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIColor
extension UIColor {
    convenience init(rgb: UInt) {
        self.init(red: CGFloat((rgb & 0xff0000) >> 16) / 255.0,
                  green: CGFloat((rgb & 0x00ff00) >> 8) / 255.0,
                  blue: CGFloat(rgb & 0x0000ff) / 255.0,
                  alpha: CGFloat(1))
    }
    
    convenience init(rgb: UInt, alpha: CGFloat) {
        self.init(red: CGFloat((rgb & 0xff0000) >> 16) / 255.0,
                  green: CGFloat((rgb & 0x00ff00) >> 8) / 255.0,
                  blue: CGFloat(rgb & 0x0000ff) / 255.0,
                  alpha: CGFloat(alpha))
    }
}
