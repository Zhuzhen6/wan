//
//  TreeViewController.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/18.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit

class TreeViewController: ZBaseViewController {
    
    private var treeDatas = [TreeModel]()
    
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
        view.addSubview(collectView)
        collectView.snp.makeConstraints { make in make.edges.equalTo(self.view.usnp.edges) }
        
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        
    }
    
    func loadData() {
        

        Network.request(.tree, model: [TreeModel].self) { (data) in
            
                self.collectView.uHead.endRefreshing()
                self.treeDatas = data!
                self.collectView.reloadData()
        }
    }
    
}



extension TreeViewController : UICollectionViewDelegate , UICollectionViewDataSource
{

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.treeDatas.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let comicList = self.treeDatas[section]
        return comicList.children?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: SearchCollectCell.reuseIdentifier, for: indexPath) as! SearchCollectCell
        let model = self.treeDatas[indexPath.section]
        let comicList = model.children![indexPath.row]
        cell.titleLable.text = comicList.name as String?;
        cell.layer.cornerRadius = cell.bounds.height * 0.5
        cell.titleLable.textColor = .white
        cell.backgroundColor = UIColor.random
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TreeCollectionHeader.reuseIdentifier, for: indexPath) as! TreeCollectionHeader
        let gradeType = self.treeDatas[indexPath.section]
        headerView.titleLabel.text = gradeType.name as String?
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = self.treeDatas[indexPath.section]
        let comicList = model.children![indexPath.row]
        
    }
}
