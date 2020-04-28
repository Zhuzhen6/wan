//
//  UserModel.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/27.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit
import HandyJSON
import Cache

class User: Codable {
    static let shared: User = {
        let config = DiskConfig(name: "Cache")
        let diskStorage = try? DiskStorage<User>(config: config, transformer: TransformerFactory.forCodable(ofType: User.self))
        var shared = try? diskStorage?.object(forKey: "User")
        if shared == nil {
            shared = User()
        }
        return shared!
    }()
    
    var isLogin = false {
        didSet {
            try? saveOnDisk()
            NotificationCenter.default.post(name: User.loginStatusDidChangeNotification, object: self)
        }
    }
    
    var userInfo: UserModel?
    
    var account: String?
    
    var token: String? {
        return userInfo?.token
    }
    
    func setup(model :UserModel) {
        userInfo = model
        isLogin = true
    }
    
    func saveOnDisk() throws {
        let config = DiskConfig(name: "Cache")
        let diskStorage = try DiskStorage<User>(config: config, transformer: TransformerFactory.forCodable(ofType: User.self))
        if isLogin {
            try diskStorage.setObject(self, forKey: "User")
        } else {
            try diskStorage.removeObject(forKey: "User")
        }
    }
    
    func logout() {
        userInfo = nil
        isLogin = false
        Network.request(.logout, model: BaseModel<User.UserModel>.self) { (data) in
            print("已经退出")
        }
    }
}

extension User {
    static let loginStatusDidChangeNotification = Notification.Name(rawValue: "loginStatusDidChangeNotification")
}

extension User {
    struct UserModel: HandyJSON,Codable {
        var id: Int?
        var icon: String?
        var username: String?
        var password: String?
        var email: String?
        var token: String?
        var collectIds: [Int]?
    }
}


class CoinModel: HandyJSON {
    
    var userId: Int?
    var username: String?
    var coinCount: Int = 0//总积分
    var rank: Int = 0//排名
    var level: Int = 1//等级
    
    required init() {}
}

class CoinListModel: HandyJSON {
    
    var coinCount: Int?
    var date: String?
    var desc: String?
    var id: Int?
    var userId: Int?
    var reason: String?
    var type: Int = 0
    var userName: String?
    
    required init() {}
}
