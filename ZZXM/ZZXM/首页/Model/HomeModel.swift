//
//  HomeModel.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/16.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit
import HandyJSON


class ArticleDetailModel: HandyJSON {

    var title: String?
    var author: String?
    var chapterName: String?
    var link: String?
    var niceDate: String?
    var niceShareDate: String?
    var superChapterName: String?
    var collect: Bool = true//是否收藏
    var id: Int? //文章id
    required init() {}
}



class SearchModel: HandyJSON {
    
    var id: Int?
    var link: String?
    var name: String?
    var order: Int?
    var visible: Int?
    required init() {}
}


class BannerModel: HandyJSON {

    var id: Int?
    var desc: String?
    var imagePath: String?
    var title: String?
    var isVisible: Int?
    var order: Int?
    var type: Int?
    var url: String?
    
    required init() {}
    
}
