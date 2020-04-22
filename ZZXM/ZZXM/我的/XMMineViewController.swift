//
//  XMMineViewController.swift
//  ZZXM
//
//  Created by TonghuiMac on 2018/10/23.
//  Copyright © 2018 TonghuiMac. All rights reserved.
//

import UIKit


class XMMineViewController: UIViewController {

    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero,style: .grouped)
        if #available(iOS 11.0, *)
        {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        return tableView
    }()
    
    lazy var tableHeaderView = MineTableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: MineTableHeaderView.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        tableView.tableHeaderView = tableHeaderView

        tableView.register(UINib(nibName: "MineTableCell", bundle: nil), forCellReuseIdentifier: MineTableCell.reuseIdentifier)
    }
    
}


extension XMMineViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineTableCell.reuseIdentifier, for: indexPath) as! MineTableCell
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.iconImageView.image = UIImage(named: "icon_my01")
                cell.titleLabel.text = "优惠券"
                cell.descLabel.isHidden = true
            } else if indexPath.row == 1 {
                cell.iconImageView.image = UIImage(named: "icon_my02")
                cell.titleLabel.text = "最新活动"
                cell.descLabel.isHidden = true
            }
        } else {
            if indexPath.row == 0 {
                cell.iconImageView.image = UIImage(named: "icon_my03")
                cell.titleLabel.text = "消息中心"
                cell.descLabel.isHidden = true
            } else if indexPath.row == 1 {
                cell.iconImageView.image = UIImage(named: "icon_my04")
                cell.titleLabel.text = "我的客服"
                cell.descLabel.isHidden = false
            } else {
                cell.iconImageView.image = UIImage(named: "icon_my05")
                cell.titleLabel.text = "意见反馈"
                cell.descLabel.isHidden = true
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20
        } else {
            return onePixelWidth
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        if section == 0 {
//            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SeparatorLineFooterView.reuseIdentifier) as! SeparatorLineFooterView
//            return footerView
//        } else {
//            return nil
//        }
//    }
}

extension XMMineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}
