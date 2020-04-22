//
//  CommonData.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/15.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit
import HandyJSON



class Collect: HandyJSON {
    
    required init() {}
    
}

class User: HandyJSON {

    var id: Int?
    var publicName: String?
    var email: String?
    var collectIds: [Collect]!
    var icon: String?
    
    required init() {}
    
}


extension Array: HandyJSON{}//保证BaseModel下为数组模型 例如:[BannerModel]

class BaseModel<T: HandyJSON>: HandyJSON {

    var data: T?
    var errorCode: Int?
    var errorMsg: String?
    
    required init() {}
    
}
