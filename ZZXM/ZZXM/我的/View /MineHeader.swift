//
//  MineHeader.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/28.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit

class MineHeader: UIView {
    
    lazy var headImg: UIImageView = {
        
        let headImg = UIImageView(image: UIImage(named: "头像"))
        headImg.layer.cornerRadius = 40
        headImg.layer.masksToBounds = true
        return headImg
    }()
    
    lazy var nameLab: UILabel = {
        let nameLab = UILabel()
        nameLab.font = .systemFont(ofSize: 17)
        nameLab.textAlignment = .center
        nameLab.textColor = .white
        nameLab.text = "未登录"
        return nameLab
    }()
    
    lazy var detailLab: UILabel = {
        let detailLab = UILabel()
        detailLab.font = .systemFont(ofSize: 14)
        detailLab.textAlignment = .center
        detailLab.textColor = .white
        detailLab.text = "等级0 排名0 积分0"
        return detailLab
    }()

    override init(frame: CGRect) {
        super.init(frame:frame)
        addUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addUI()
    }
    
    private func addUI()
    {
        backgroundColor = themColor
        
        addSubview(headImg)
        headImg.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        addSubview(nameLab)
        nameLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(headImg.snp.bottom).offset(5)
            make.size.equalTo(CGSize(width: 300, height: 30))
        }
        
        addSubview(detailLab)
        detailLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLab.snp.bottom).offset(2)
            make.size.equalTo(CGSize(width: 300, height: 30))
        }
        
        onLoginStatusChanged()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onLoginStatusChanged(_:)), name: User.loginStatusDidChangeNotification, object: nil)
    }
    
    
    @objc func onLoginStatusChanged(_ notification: Notification? = nil) {
        
        if User.shared.isLogin {
            let userInfo = User.shared.userInfo!
            nameLab.text = userInfo.username
            
            Network.request(.coin, model: CoinModel.self) { (data) in
                
                let model = data!
                
                self.detailLab.text = "等级\(model.level)  排名\(model.rank )   积分\(model.coinCount)"
                
            }
        }
        else
        {
            nameLab.text = "未登录"
            detailLab.text = "等级0 排名0 积分0"
        }
    }
}
