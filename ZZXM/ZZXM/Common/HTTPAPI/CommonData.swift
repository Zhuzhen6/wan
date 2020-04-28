//
//  CommonData.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/15.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit
import HandyJSON


extension Array: HandyJSON{}//保证BaseModel下为数组模型 例如:[BannerModel]

class BaseModel<T: HandyJSON>: HandyJSON {

    var data: T?
    var errorCode: Int?
    var errorMsg: String?
    
    required init() {}
    
}

class PageModel<T: HandyJSON>: HandyJSON {
    
    var datas: [T]?
    var curPage: Int = 0
    var offset: Int?
    var over: Bool = false
    var pageCount: Int?
    var size: Int?
    var total: Int?
    required init() {}
}
