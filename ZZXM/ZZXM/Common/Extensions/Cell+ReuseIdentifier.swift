//
//  Cell+ReuseIdentifier.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/14.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit

protocol ReusableView: class {}

extension UITableViewCell: ReusableView {}
//extension UICollectionViewCell: ReusableView {}
extension UITableViewHeaderFooterView: ReusableView {}
extension UICollectionReusableView: ReusableView {}

extension ReusableView  {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
