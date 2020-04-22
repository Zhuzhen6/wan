//
//  UIScreen+Bounds.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/14.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit

let actualStatusBarHeight = UIApplication.shared.statusBarFrame.height

extension UIScreen {
    
    static var width: CGFloat
    {
        return main.bounds.width
    }
    
    static var height: CGFloat
    {
        return main.bounds.height
    }
}

