//
//  BookPageViewController.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/26.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit
import JXSegmentedView

class BookPageViewController: ZBaseViewController {
    
    var segmentedDataSource: JXSegmentedBaseDataSource?
    let segmentedView = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    private var listArray = [BookListModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        requestData()
        
    }
    
    override func configNavigationBar() {
        
        super.configNavigationBar()
    }
    
    private func addPage()
    {
        segmentedView.delegate = self
        view.addSubview(segmentedView)

        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)
        
                   //配置数据源
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titleNormalColor = UIColor.white.withAlphaComponent(0.5)
        dataSource.titleSelectedColor = .white
        dataSource.titleNormalFont = .systemFont(ofSize: 18)
        dataSource.titleSelectedFont = .systemFont(ofSize: 20)
        
        let filterArr = self.listArray.filter { $0.name != nil }.map { $0.name! }
     //   let titles = ["猴哥", "青蛙王子", "旺财"]
        dataSource.titles = filterArr
        segmentedDataSource = dataSource
        segmentedView.dataSource = segmentedDataSource
    
        //配置指示器
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 20
        indicator.lineStyle = .lengthen
        segmentedView.indicators = [indicator]
        
        segmentedView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 50)
        listContainerView.frame = self.view.bounds
        
        //放在导航栏
        navigationItem.titleView = segmentedView
    }
    
    private func requestData()
    {
        Network.request(.projectlist, model: [BookListModel].self) { (returnData) in

            self.listArray = returnData!
            self.addPage()
            self.segmentedView.reloadData()
            
        }
    }
    
}

extension BookPageViewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            //先更新数据源的数据
            dotDataSource.dotStates[index] = false
            //再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
        }

        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
        
    }

}


extension BookPageViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        let model = self.listArray[index]
        
        let vc = BookViewController()
        vc.requestBookData(page: 0, cid: model.id!)
        return vc
    }
}
