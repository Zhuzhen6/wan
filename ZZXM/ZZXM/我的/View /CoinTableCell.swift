//
//  CoinTableCell.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/28.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit

class CoinTableCell: UITableViewCell {

    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var dateLab: UILabel!
    @IBOutlet weak var scoreLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: CoinListModel? {
        didSet {
            guard let viewModel = viewModel else { return }

            nameLab.text = viewModel.userName
            dateLab.text = viewModel.desc
            scoreLab.text = "加\(viewModel.coinCount!)分"
        }
    }
    
}
