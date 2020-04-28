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
    //注册
    case register(parameters:[String: Any])
    //退出
    case logout
    //个人积分
    case coin
    //积分列表
    case coinlist(page: Int)
    //搜索
    case hotkey
    //首页文章
    case article(page: Int)
    //体系
    case tree
    //导航数据
    case navi
    //项目分类
    case projectlist
    //项目文章
    case project(page: Int,cid: Int)
    //收藏文章
    case collect(articleid: Int)
    //取消收藏
    case uncollect_originId(articleid: Int)
    
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
        case .register:
            return "user/register"
        case .logout:
            return "user/logout/json"
        case .coin:
            return "lg/coin/userinfo/json"
        case .coinlist(let page):
            return "lg/coin/list/\(page)/json"
        case .hotkey:
            return "hotkey/json"
        case .article(let page):
            return "article/list/\(page)/json"
        case .tree:
            return "tree/json"
        case .navi:
            return "navi/json"
        case .projectlist:
            return "project/tree/json"
        case .project(let page, _):
            return "project/list/\(page)/json"
        case .collect(let articleid):
                return "lg/collect/\(articleid)/json"
        case .uncollect_originId(let articleid):
        return "lg/uncollect_originId/\(articleid)/json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .collect:
            return .post
        case .uncollect_originId:
            return .post
        case .register:
            return .post
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
        var parmeters: [String : Any] = [:]
        switch self {
        case .register(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .login(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .project( _, let cid):
            parmeters["cid"] = cid
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
            
    }
    
}

