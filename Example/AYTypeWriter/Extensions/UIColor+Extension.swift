//
//  UIColor+Extension.swift
//  AYTypeWriterView
//
//  Created by Anson Yao on 2018-09-22.
//  Copyright © 2018 Anson Yao. All rights reserved.
//

import UIKit

extension UIColor {
    static func getColor(rgb: (Int, Int, Int)) -> UIColor {
        return UIColor(red: CGFloat(rgb.0)/255.0, green: CGFloat(rgb.1)/255.0, blue: CGFloat(rgb.2)/255.0, alpha: 1.0)
    }
}
