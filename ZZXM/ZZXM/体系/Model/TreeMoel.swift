//
//  TreeMoel.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/18.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit
import HandyJSON


class ChildrenModel: HandyJSON {
    
    var children: NSArray?
    var courseId: Int?
    var id: Int?
    var name: NSString?
    var order: Int?
    var parentChapterId: Int?
    var visible: Int?
    required init() {}
}


class TreeModel: HandyJSON {
    
    var children: [ChildrenModel]?
    var courseId: Int?
    var id: Int?
    var name: NSString?
    var order: Int?
    var parentChapterId: Int?
    var visible: Int?
    required init() {}
}


class ArticleMoel: HandyJSON {
    
    var id: Int?
    var chapterId: Int?
    var title: NSString?
    var link: NSString?
    required init() {}
}


class NaviMoel: HandyJSON {
    
    var articles: [ArticleMoel]?
    var id: Int?
    var name: NSString?
    required init() {}
}
