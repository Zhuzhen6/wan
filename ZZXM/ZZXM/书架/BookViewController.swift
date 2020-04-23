//
//  XMBookViewController.swift
//  ZZXM
//
//  Created by TonghuiMac on 2018/10/23.
//  Copyright © 2018 TonghuiMac. All rights reserved.
//

import UIKit
import HMSegmentedControl

class BookViewController: ZBaseViewController {
    
    
    private var bookModel = BookModel()
    private var listArray = [BookDetailModel]()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = bgColor
        tableView.separatorStyle = .none
        tableView.register(BookCell.self, forCellReuseIdentifier: BookCell.reuseIdentifier)
        tableView.uFoot = URefreshFooter {
            
            self.requestBookData(page: self.bookModel.curPage + 1)
        }
        tableView.uHead = URefreshHeader{
            self.requestBookData(page: 0)
        }
        
        return tableView
    }()
    
    lazy var page: HMSegmentedControl = {
        let page = HMSegmentedControl()
        page.backgroundColor = themColor
        page.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5),
                                       NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        page.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                               NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        page.selectionIndicatorLocation = .down
        page.selectionIndicatorColor = .white
        page.selectionIndicatorHeight = 2
        page.addTarget(self, action: #selector(changeIndex(segment:)), for: .valueChanged)
        return page
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestBookData(page: 0)
    }
    
    override func setupLayout() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {make in make.edges.equalTo(self.view.usnp.edges) }
        
        view.addSubview(page)
        page.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(self.view.snp.top)
            $0.height.equalTo(80)
        }
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        
        page.sectionTitles = ["体系","导航",]
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func requestBookData(page: Int)
    {
        
        Network.request(.project(page: page, cid: 294), model: BookModel.self) { (returnData) in

            if returnData?.over == false {
                self.tableView.uFoot.endRefreshing()
            } else {
                self.tableView.uFoot.endRefreshingWithNoMoreData()
            }
            if page == 0{
                self.tableView.uHead.endRefreshing()
            }
            self.bookModel = returnData!
            self.listArray.append(contentsOf: self.bookModel.datas!)
            self.tableView.reloadData()
        }
    }
    
    @objc func changeIndex(segment: UISegmentedControl) {
        
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
