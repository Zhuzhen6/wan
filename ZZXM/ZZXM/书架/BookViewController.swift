//
//  XMBookViewController.swift
//  ZZXM
//
//  Created by TonghuiMac on 2018/10/23.
//  Copyright © 2018 TonghuiMac. All rights reserved.
//

import UIKit
import JXSegmentedView
class BookViewController: ZBaseViewController {
    
    private var bookModel = PageModel<BookDetailModel>()
    private var listArray = [BookDetailModel]()
    
    var Cid:Int?
    

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = bgColor
        tableView.separatorStyle = .none
        tableView.register(BookCell.self, forCellReuseIdentifier: BookCell.reuseIdentifier)
        tableView.uFoot = URefreshFooter {
            
            self.requestBookData(page: self.bookModel.curPage + 1 ,cid:self.Cid! )
        }
        tableView.uHead = URefreshHeader{
            self.requestBookData(page: 0,cid: self.Cid!)
        }
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupLayout() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {make in make.edges.equalTo(self.view.usnp.edges) }
        
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        
    }
    
    
    open func requestBookData(page: Int,cid: Int)
    {
        
        Network.request(.project(page: page, cid: cid), model: PageModel<BookDetailModel>.self) { (returnData) in

            self.Cid = cid
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
            self.bookModel = returnData!
            self.listArray.append(contentsOf: self.bookModel.datas!)
            self.tableView.reloadData()
        }
    }
    

}

extension BookViewController: UITableViewDelegate,UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        if section ==  0{
            return CGFloat.leastNormalMagnitude
        }else
        {
            return 5
        }

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

  
        return nil

    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.reuseIdentifier, for: indexPath) as! BookCell
        cell.selectionStyle = .none
        cell.viewModel = listArray[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let resource = self.listArray[indexPath.section]
        let urlString = resource.link
        let controller = ZWebController(url: urlString!)
        self.navigationController!.pushViewController(controller, animated: true)
    }
}



extension BookViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
