//
//  MyCollectTableCell.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/28.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit

class MyCollectTableCell: UITableViewCell {
    
    lazy var descLabel : UILabel = {
       
        let descLabel = UILabel()
        descLabel.textColor = .black
        descLabel.font = .systemFont(ofSize: 15)
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    lazy var dateLabel : UILabel = {
       
        let dateLabel = UILabel()
        dateLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textAlignment = .right
        return dateLabel
    }()
    
    lazy var authorLabel : UILabel = {
       
        let authorLabel = UILabel()
        authorLabel.textColor = .gray
        authorLabel.font = .systemFont(ofSize: 12)
        return authorLabel
    }()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
