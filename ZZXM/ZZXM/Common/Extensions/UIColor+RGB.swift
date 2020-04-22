//
//  UIColor+RGB.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/14.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit

extension UIColor {
       
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
    class var random: UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)),
                       green: CGFloat(arc4random_uniform(256)),
                       blue: CGFloat(arc4random_uniform(256)))
    }
    
    func image() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    static let darkTextColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    static let normalTextColor = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
    static let lightTextColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
    

    static let e64919 = #colorLiteral(red: 0.9019607843, green: 0.2862745098, blue: 0.09803921569, alpha: 1)
    static let f5f5f5 = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
    static let f7f7f7 = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    static let fcece8 = #colorLiteral(red: 0.9882352941, green: 0.9254901961, blue: 0.9098039216, alpha: 1)
    static let a6aeb9 = #colorLiteral(red: 0.6509803922, green: 0.6823529412, blue: 0.7254901961, alpha: 1)
    static let fff7e9 = #colorLiteral(red: 1, green: 0.968627451, blue: 0.9137254902, alpha: 1)
    static let ff4d00 = #colorLiteral(red: 1, green: 0.3019607843, blue: 0, alpha: 1)
    static let fefefe = #colorLiteral(red: 0.9960784314, green: 0.9960784314, blue: 0.9960784314, alpha: 1)
    static let cdcdcd = #colorLiteral(red: 0.8039215686, green: 0.8039215686, blue: 0.8039215686, alpha: 1)
    static let dcdcdc = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
    static let d5d5d5 = #colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.8352941176, alpha: 1)
    static let f3f3f3 = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
    static let b9b9b9 = #colorLiteral(red: 0.7254901961, green: 0.7254901961, blue: 0.7254901961, alpha: 1)
    static let e5e5e5 = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
}
