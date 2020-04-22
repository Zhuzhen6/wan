//
//  PixelWidth.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/14.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit

let onePixelWidth = 1 / UIScreen.main.scale

extension Float {
    var ylCeil: Float {
        let scale = Float(UIScreen.main.scale)
        var result = scale * self
        result = ceilf(result)
        result = result / scale
        return result
    }
    
    var ylFloor: Float {
        let scale = Float(UIScreen.main.scale)
        var result = scale * self
        result = floorf(result)
        result = result / scale
        return result
    }
}

extension Double {
    var ylCeil: Double {
        let scale = Double(UIScreen.main.scale)
        var result = scale * self
        result = ceil(result)
        result = result / scale
        return result
    }
    
    var ylFloor: Double {
        let scale = Double(UIScreen.main.scale)
        var result = scale * self
        result = floor(result)
        result = result / scale
        return result
    }
}

extension CGFloat {
    var ylCeil: CGFloat {
        let scale = UIScreen.main.scale
        var result = scale * self
        result = CGFloat(ceilf(Float(result)))
        result = result / scale
        return result
    }
    
    var ylFloor: CGFloat {
        let scale = UIScreen.main.scale
        var result = scale * self
        result = CGFloat(floorf(Float(result)))
        result = result / scale
        return result
    }
}



