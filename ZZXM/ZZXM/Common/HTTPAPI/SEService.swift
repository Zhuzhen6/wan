//
//  SEService.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/15.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import Foundation
import Moya


enum API
{
    //轮播
    case banner
    //登陆
    case login(parameters:[String: Any])
    //搜索
    case hotkey
    //首页文章
    case article(page: Int)
    //体系
    case tree
    //导航数据
    case navi
}


extension API:TargetType
{
    var baseURL: URL{
        
        return URL(string: "https://www.wanandroid.com/")!
    }
    var path: String {
        switch self {
        case .banner:
            return "banner/json"
        case .login:
            return "user/login"
        case .hotkey:
            return "hotkey/json"
        case .article(let page):
            return "article/list/\(page)/json"
        case .tree:
            return "tree/json"
        case .navi:
            return "navi/json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var task: Task {
        
        switch self {
        case .login(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
            
    }
    
}

