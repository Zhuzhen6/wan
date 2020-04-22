//
//  UIButton+QuickUI.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/14.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit

extension UIButton{
    
    convenience init(type: UIButton.ButtonType = .custom, image: UIImage? = nil, backgroundImage: UIImage? = nil, title: String? = nil, target: Any? = nil, selector: Selector? = nil)
    {
        self.init(type: type)
        setImage(image, for: .normal)
        setBackgroundImage(backgroundImage, for: .normal)
        setTitle(title, for: .normal)
        if let selector = selector {
            
            addTarget(target, action: selector, for: .touchUpInside)
        }
    }
}
