//
//  CoinListViewController.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/28.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit

class CoinListViewController: ZBaseViewController {
    
    private var coinModel = PageModel<CoinListModel>()
    private var listArray = [CoinListModel]()
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero,style: .grouped)
        if #available(iOS 11.0, *)
        {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 65
        tableView.uFoot = URefreshFooter {
            
            self.requestCoinListData(page: self.coinModel.curPage + 1)
        }
        tableView.uHead = URefreshHeader{
            self.requestCoinListData(page: 0)
        }
        
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        requestCoinListData(page: 0)
    }
      
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }

        tableView.register(UINib(nibName: "CoinTableCell", bundle: nil), forCellReuseIdentifier: CoinTableCell.reuseIdentifier)
        
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        
    }
    
    open func requestCoinListData(page: Int)
    {
        
        Network.request(.coinlist(page: page), model: PageModel<CoinListModel>.self) { (returnData) in

            if returnData?.over == false {
                self.tableView.uFoot.endRefreshing()
            } else {
                self.tableView.uFoot.endRefreshingWithNoMoreData()
                return
            }
            if page == 0{
                self.tableView.uHead.endRefreshing()
                self.listArray.removeAll()
            }
            self.coinModel = returnData!
            self.listArray.append(contentsOf: self.coinModel.datas!)
            self.tableView.reloadData()
        }
    }
    
}

extension CoinListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableCell.reuseIdentifier, for: indexPath) as! CoinTableCell
        
        cell.selectionStyle = .none
        cell.viewModel = listArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return onePixelWidth

    }
      
 
}
