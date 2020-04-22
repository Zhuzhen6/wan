//
//  SearchViewController.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/16.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit

class SearchCollectCell: UICollectionViewCell {
    
    lazy var titleLable :UILabel = {
       
        let titleLab = UILabel()
        titleLab.textAlignment = .center
        titleLab.font = .systemFont(ofSize: 14)
        titleLab.textColor = .white
        return titleLab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI()
    {
        contentView.addSubview(titleLable)
        titleLable.snp.makeConstraints { (maker) in
            
            maker.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 18, bottom: 10, right: 18))
        }
    }
}


class SearchViewController: ZBaseViewController {
    
    private var searhKeyDatas = [SearchModel]()
    
    private lazy var searchBar: UITextField = {
        let searchBar = UITextField()
        searchBar.backgroundColor = .white
        searchBar.textColor = .gray
        searchBar.font = .systemFont(ofSize: 15)
        searchBar.placeholder = "请输入关键字"
        searchBar.layer.cornerRadius = 15
        searchBar.layer.masksToBounds = true
        searchBar.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        searchBar.leftViewMode = .always
        searchBar.clearsOnBeginEditing = true
        searchBar.clearButtonMode = .whileEditing
        searchBar.returnKeyType = .search
        searchBar.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledTextDidChange(noti:)), name: UITextField.textDidChangeNotification, object: searchBar)
        
        return searchBar
    }()
    
    
    private lazy var collectView :UICollectionView = {
      
        let layout = UCollectionViewAlignedLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.estimatedItemSize = CGSize(width: 100, height: 40)
        layout.horizontalAlignment = .left
        let collectView = UICollectionView(frame: .zero ,collectionViewLayout: layout)
        collectView.delegate = self
        collectView.dataSource = self
        collectView.register(SearchCollectCell.classForCoder(), forCellWithReuseIdentifier: SearchCollectCell.reuseIdentifier)
        collectView.backgroundColor = bgColor
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
        searchBar.frame = CGRect(x: 0, y: 0, width: screenWidth - 50, height: 30)
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: nil,
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消",
                                                            style: .plain,
                                                            target: self,
            action: #selector(cancelAction))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func loadData() {
        

        Network.request(.hotkey, model: [SearchModel].self) { (data) in
            
                self.searhKeyDatas = data!
                self.collectView.reloadData()
        }
    }
    
    @objc private func cancelAction() {
        searchBar.resignFirstResponder()
        navigationController?.popViewController(animated: true)
    }
    
    
    private func searchAction(text :String)
    {
        
    }
}



extension SearchViewController: UITextFieldDelegate
{
    @objc func textFiledTextDidChange(noti: Notification)
    {
   
        guard let textField = noti.object as? UITextField,
        let text = textField.text else {
            return
        }
        
        searchAction(text: text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

extension SearchViewController : UICollectionViewDelegate , UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.searhKeyDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: SearchCollectCell.reuseIdentifier, for: indexPath) as! SearchCollectCell
        let model = self.searhKeyDatas[indexPath.row]
        cell.titleLable.text = model.name;
        cell.layer.cornerRadius = cell.bounds.height * 0.5
        cell.titleLable.textColor = .white
        cell.backgroundColor = UIColor.random
        return cell
    }
    
    
}
