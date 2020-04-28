//
//  XMTabBarController.swift
//  ZZXM
//
//  Created by TonghuiMac on 2018/10/23.
//  Copyright © 2018 TonghuiMac. All rights reserved.
//

import UIKit

class ZTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChilds()
    }
}

extension ZTabBarController{
    
    func addChilds() {
        
        tabBar.isTranslucent = false;
        /// 首页
        let home = HomeViewController()
        setupChild(childController: home, title: "首页", image: "tab_home")
        
        //体系分页
        let treePageVC = TreeAndNaviViewController(titles: ["体系","导航",],
                                            vcs: [TreeViewController(),
                                                  NaviViewController()],
                                            pageStyle: .navgationBarSegment)
        
        setupChild(childController: treePageVC, title: "体系", image: "tab_class")
        
        
        let bookPageVC = BookPageViewController()
        setupChild(childController: bookPageVC, title: "书架", image: "tab_book")
        
        
        /// 我的
        let mine = MineViewController()
        setupChild(childController: mine, title: "我的", image: "tab_mine")
        
    }
    
    func setupChild(childController:UIViewController,title:String,image:String) {
        
        childController.title = title;
        childController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: image)?.withRenderingMode(.alwaysOriginal),selectedImage: UIImage(named: image+"_S")?.withRenderingMode(.alwaysOriginal))
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        
        addChild(ZNavigationController(rootViewController: childController))
    }
    
}

extension ZTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}



