//
//  BookModel.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/23.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit
import HandyJSON

class BookListModel: HandyJSON {

    var name: String?
    var id: Int? //分类id
    required init() {}
}


class BookDetailModel: HandyJSON {

    var author: String?
    var niceDate: String?
    var niceShareDate: String?
    var title: String?
    var envelopePic :String?
    var desc: String?
    var link: String?
    var superChapterName: String?
    var collect: Bool?//是否收藏
    var id: Int? //文章id

    required init() {}
}

