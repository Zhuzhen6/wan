//
//  NaviCell.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/20.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit

class NaviCell: UITableViewCell {
    
    lazy var titleLable :UILabel = {
       
        let titleLab = UILabel()
        titleLab.textColor = UIColor(red: 51, green: 51, blue: 51)
        titleLab.textAlignment = .center
        return titleLab
    }()
    
    private lazy var indicatedView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        contentView.backgroundColor = selected ? UIColor.white : bgColor
        isHighlighted = selected
        titleLable.isHighlighted = selected
        indicatedView.isHidden = !selected
        titleLable.font = .systemFont(ofSize: selected ? 17 : 14, weight: UIFont.Weight.medium)

    }
    
    func setupUI()
    {
        contentView.addSubview(titleLable)
        titleLable.snp.makeConstraints { (maker) in
            
            maker.edges.equalToSuperview()
        }
        
        indicatedView.backgroundColor = themColor
        contentView.addSubview(indicatedView)
        indicatedView.snp.makeConstraints { (maker) in
            
            maker.centerY.equalToSuperview()
            maker.size.equalTo(CGSize(width: 4, height: 15))
        }
    }
}
