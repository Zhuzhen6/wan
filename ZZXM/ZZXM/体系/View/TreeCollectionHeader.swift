//
//  TreeCollectionHeader.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/18.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit

class TreeCollectionHeader: UICollectionReusableView {
    let titleLabel = UILabel().then { (label) in
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .darkTextColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(19)
            make.centerY.equalTo(self).offset(5)
        }
    }
}
