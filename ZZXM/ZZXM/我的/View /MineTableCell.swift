//
//  MineTableCell.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/27.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//


import UIKit

class MineTableCell: UITableViewCell {
    
    @IBOutlet var iconImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
