//
//  NaviViewController.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/20.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit

class NaviViewController: ZBaseViewController {

    private var naviDatas = [NaviMoel]()
    private var isScrollDown = true
    private var lastOffsetY : CGFloat = 0.0
    private var selectIndex = 0
    

    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 245, green: 245, blue: 245)
        tableView.register(NaviCell.self, forCellReuseIdentifier: NaviCell.reuseIdentifier)
        return tableView
    }()
    
    lazy var collectView :UICollectionView = {
      
        let layout = UCollectionViewAlignedLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.estimatedItemSize = CGSize(width: 100, height: 40)
        //头部高度
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 30)
        layout.horizontalAlignment = .left
        let collectView = UICollectionView(frame: .zero ,collectionViewLayout: layout)
        collectView.delegate = self
        collectView.dataSource = self
        collectView.register(SearchCollectCell.self, forCellWithReuseIdentifier: SearchCollectCell.reuseIdentifier)
        collectView.register(TreeCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TreeCollectionHeader.reuseIdentifier)
        collectView.backgroundColor = .white
        collectView.uHead  = URefreshHeader{
                   
                   self.loadData()
               }
        return collectView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func setupLayout() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.height.top.left.equalToSuperview()
            make.width.equalTo(90)
        }
        view.addSubview(collectView)
        
        collectView.snp.makeConstraints { make in
            make.height.top.right.equalToSuperview()
            make.left.equalTo(90)
        }
        
    }

    override func configNavigationBar() {
        super.configNavigationBar()
        
    }
    
    func loadData() {
        

        Network.request(.navi, model: [NaviMoel].self) { (data) in
            
                self.collectView.uHead.endRefreshing()
                self.naviDatas = data!
                self.collectView.reloadData()
                self.tableView.reloadData()
                //默认选中第一行
                let indexPath = NSIndexPath.init(row: 0, section: 0)
                
                self.tableView .selectRow(at: indexPath as IndexPath, animated: true, scrollPosition: UITableView.ScrollPosition.none)
                //调用此方法,显示我们自定义的选中颜色
                self.tableView(self.tableView, didSelectRowAt: indexPath as IndexPath)
                
        }
    }
  
}



extension NaviViewController :UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.naviDatas.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NaviCell.reuseIdentifier, for: indexPath) as! NaviCell
        let gradeType = self.naviDatas[indexPath.row]
        cell.titleLable.text = gradeType.name as String?
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectIndex = indexPath.row
        // 解决点击 TableView 后 CollectionView 的 Header 遮挡问题。
        scrollToTop(section: selectIndex, animated: true)
        
        tableView.scrollToRow(at: IndexPath(row: selectIndex, section: 0), at: .top, animated: true)
        

        
    }
    
    //MARK: - 解决点击 TableView 后 CollectionView 的 Header 遮挡问题。
    fileprivate func scrollToTop(section: Int, animated: Bool) {
        let headerRect = frameForHeader(section: section)
        let topOfHeader = CGPoint(x: 0, y: headerRect.origin.y - collectView.contentInset.top)
        collectView.setContentOffset(topOfHeader, animated: animated)
    }
    
    fileprivate func frameForHeader(section: Int) -> CGRect {
        let indexPath = IndexPath(item: 0, section: section)
        let attributes = collectView.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        guard let frameForFirstCell = attributes?.frame else {
            return .zero
        }
        return frameForFirstCell;
    }
}


extension NaviViewController : UICollectionViewDelegate , UICollectionViewDataSource
{

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.naviDatas.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let comicList = self.naviDatas[section]
        return comicList.articles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: SearchCollectCell.reuseIdentifier, for: indexPath) as! SearchCollectCell
        let model = self.naviDatas[indexPath.section]
        let comicList = model.articles![indexPath.row]
        cell.titleLable.text = comicList.title as String?;
        cell.layer.cornerRadius = cell.bounds.height * 0.5
        cell.titleLable.textColor = .white
        cell.backgroundColor = UIColor.random
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TreeCollectionHeader.reuseIdentifier, for: indexPath) as! TreeCollectionHeader
        let gradeType = self.naviDatas[indexPath.section]
        headerView.titleLabel.text = gradeType.name as String?
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = self.naviDatas[indexPath.section]
        let comicList = model.articles![indexPath.row]
        
    }
    
    // CollectionView 分区标题即将展示
       func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
           // 当前 CollectionView 滚动的方向向上，CollectionView 是用户拖拽而产生滚动的（主要是判断 CollectionView 是用户拖拽而滚动的，还是点击 TableView 而滚动的）
           if !isScrollDown && (collectionView.isDragging || collectionView.isDecelerating) {
               selectRow(index: indexPath.section)
           }
       }
       
       // CollectionView 分区标题展示结束
       func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
           // 当前 CollectionView 滚动的方向向下，CollectionView 是用户拖拽而产生滚动的（主要是判断 CollectionView 是用户拖拽而滚动的，还是点击 TableView 而滚动的）
           if isScrollDown && (collectionView.isDragging || collectionView.isDecelerating) {
               selectRow(index: indexPath.section + 1)
           }
       }
       
       // 当拖动 CollectionView 的时候，处理 TableView
       private func selectRow(index : Int) {
           tableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .middle)
       }
       
       // 标记一下 CollectionView 的滚动方向，是向上还是向下
       func scrollViewDidScroll(_ scrollView: UIScrollView) {
           if collectView == scrollView {
               isScrollDown = lastOffsetY < scrollView.contentOffset.y
               lastOffsetY = scrollView.contentOffset.y
           }
       }
}


