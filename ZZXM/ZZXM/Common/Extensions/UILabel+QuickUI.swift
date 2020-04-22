//
//  UILabel+QuickUI.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/14.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(font: UIFont?, textColor: UIColor?)
    {
        self.init()
        self.font = font
        self.textColor = textColor
    }
}
