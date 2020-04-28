//
//  MineViewController.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/27.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit

class MineViewController: ZBaseViewController {
    
    
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
    
    lazy var tableHeaderView = MineHeader(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: 180))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkLogin()
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
    }
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        tableView.tableHeaderView = tableHeaderView
        
        tableView.register(UINib(nibName: "MineTableCell", bundle: nil), forCellReuseIdentifier: MineTableCell.reuseIdentifier)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(fingerTapped(gestureRecognizer:)))
        tableHeaderView.addGestureRecognizer(singleTap)
    }
    

    
    @objc func fingerTapped(gestureRecognizer:UITapGestureRecognizer)
    {
        checkLogin()
    }
    
    private func checkLogin()
    {
        let user = User.shared
        if !user.isLogin {
            
            showLogin()
        }
    }
    
}

extension MineViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MineTableCell.reuseIdentifier, for: indexPath) as! MineTableCell
        
        if indexPath.row == 0 {
            cell.iconImageView.image = UIImage(named: "icon_my01")
            cell.titleLabel.text = "我的积分"
            cell.descLabel.isHidden = true
        } else if indexPath.row == 1 {
            cell.iconImageView.image = UIImage(named: "icon_my02")
            cell.titleLabel.text = "我的收藏"
            cell.descLabel.isHidden = true
        }
        else if indexPath.row == 2 {
            cell.iconImageView.image = UIImage(named: "icon_my03")
            cell.titleLabel.text = "项目地址"
            cell.descLabel.isHidden = true
        }
        else if indexPath.row == 3 {
            cell.iconImageView.image = UIImage(named: "icon_my04")
            cell.titleLabel.text = "我的客服"
            cell.descLabel.isHidden = false
        }
        else
        {
            cell.iconImageView.image = UIImage(named: "icon_my05")
            cell.titleLabel.text = "退出登录"
            cell.descLabel.isHidden = true
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let user = User.shared
        if !user.isLogin {
            
            showLogin()
            return
        }
        
        if indexPath.row == 0 {
            
            let vc = CoinListViewController()
            vc.title = "我的积分"
            self.navigationController!.pushViewController(vc, animated: true)
            
            
        } else if indexPath.row == 1 {
            
        }
        else if indexPath.row == 2 {
            
            let urlString = "https://github.com/Zhuzhen6/wan"
            let controller = ZWebController(url: urlString)
            self.navigationController!.pushViewController(controller, animated: true)
        }
        else if indexPath.row == 3 {
             
            let url = NSURL(string :"tel://"+"18696731206")! as URL
            if #available(iOS 10.0, *) {
                
                if (UIApplication.shared.canOpenURL(url) ){
                    
                    UIApplication.shared.open(url, options: [:] ) { (b) in
                        
                    }
                }
                
            } else {
                
                UIApplication.shared.openURL(url)
            }
        }
        else
        {
            User.shared.logout()
            showLogin()
        }
    }
    
    
    private func showLogin()
    {
        let loginViewController = LoginViewController()
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    
}
