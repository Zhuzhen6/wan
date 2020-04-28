//
//  XMHomeViewController.swift
//  ZZXM
//
//  Created by TonghuiMac on 2018/10/23.
//  Copyright © 2018 TonghuiMac. All rights reserved.
//

import UIKit
import LLCycleScrollView
import PKHUD


class HomeViewController: ZBaseViewController {


    private var bannerDatas = [BannerModel]()
    private var articleModel = PageModel<ArticleDetailModel>()
    private var listArray = [ArticleDetailModel]()

    
    private lazy var bannerView: LLCycleScrollView = {
        let cycleScrollView = LLCycleScrollView()
        cycleScrollView.autoScrollTimeInterval = 3
        cycleScrollView.placeHolderImage = UIImage(named: "normal_placeholder")
        cycleScrollView.coverImage = UIImage()
        cycleScrollView.pageControlPosition = .center
        cycleScrollView.pageControlBottom = 20
        cycleScrollView.titleBackgroundColor = UIColor.clear
        // 点击 item 回调
        cycleScrollView.lldidSelectItemAtIndex = didSelectBanner(index:)
        return cycleScrollView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = bgColor
        tableView.separatorStyle = .none
        tableView.register(HomeViewCell.self, forCellReuseIdentifier: HomeViewCell.reuseIdentifier)
        tableView.uFoot = URefreshFooter {
            self.requestArticleData(page: self.articleModel.curPage + 1)
            
        }
        tableView.uHead = URefreshHeader{
            
            self.requestArticleData(page: 0)
        }
        return tableView
        
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestArticleData(page: 0)
        requestBaner()
    }
    
    override func setupLayout() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {make in make.edges.equalTo(self.view.usnp.edges) }
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_search")?.withRenderingMode(.alwaysOriginal), style: .done,
                                                            target: self,
                                                            action: #selector(searchButtonClick))
    }
    
    @objc private func searchButtonClick() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    
    
    private func requestBaner(){
        
        Network.request(.banner, model: [BannerModel].self) { (returnData) in

            if returnData == nil {
                return
            }
            self.bannerDatas = returnData!
            let filterArr = self.bannerDatas.filter { $0.imagePath != nil }.map { $0.imagePath! }
            self.bannerView.imagePaths = filterArr

        }

    }
    
    private func didSelectBanner(index: NSInteger) {

        let resource = self.bannerDatas[index]
        let urlString = resource.url
        let controller = ZWebController(url: urlString!)
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
    private func requestArticleData(page: Int)
    {
        
        Network.request(.article(page: page), model: PageModel<ArticleDetailModel>.self) { (returnData) in

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
            self.articleModel = returnData!
            self.listArray.append(contentsOf: self.articleModel.datas!)
            self.tableView.reloadData()
        }
    }

}
 


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section ==  0{
            return 180
        }else
        {
            return CGFloat.leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section ==  0{
            return bannerView
        }else
        {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 3//CGFloat.leastNormalMagnitude//8
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewCell.reuseIdentifier, for: indexPath) as! HomeViewCell
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 6
        cell.layer.masksToBounds = true
        let model = listArray[indexPath.section]
        cell.viewModel = model
        cell.CollectAction { [weak self] in

            self?.collect(model: model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let resource = self.listArray[indexPath.section]
        let urlString = resource.link
        let controller = ZWebController(url: urlString!)
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
    private func collect(model : ArticleDetailModel)
    {
        if !model.collect {
           
            Network.requestNOBaseModel(.collect(articleid: model.id!), model: BaseModel<ArticleDetailModel>.self) { (data) in
                
                if data?.errorCode == 0
                {
                    HUD.flash(.labeledSuccess(title: "", subtitle: "收藏成功"), delay: 1)
                    model.collect = true
                    self.tableView.reloadData()
                    
                }
                else
                {
                    HUD.flash(.labeledError(title: "错误", subtitle: data?.errorMsg), delay: 1)
                }
                
            }
        }
        else
        {
            Network.requestNOBaseModel(.uncollect_originId(articleid: model.id!), model: BaseModel<ArticleDetailModel>.self) { (data) in
                
                if data?.errorCode == 0
                {
                    HUD.flash(.labeledSuccess(title: "", subtitle: "已取消收藏"), delay: 1)
                    model.collect = false
                    self.tableView.reloadData()
                    
                }
                else
                {
                    HUD.flash(.labeledError(title: "错误", subtitle: data?.errorMsg), delay: 1)
                }
                
            }
        }
        
        
    }
    
}
