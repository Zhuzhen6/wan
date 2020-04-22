//
//  MineTableHeaderView.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/14.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit
import Then
import SnapKit


class MineTableHeaderView: UIView {
    
    static let height: CGFloat = {
        var height: CGFloat = actualStatusBarHeight + 67
        var imageHeight: CGFloat = UIScreen.width * 338 / 750
        
        return height + imageHeight - 28 + 78 + 15
    }()
        
    lazy var loginControl = UIControl().then { view in
        view.backgroundColor = .clear
        let imageView = UIImageView(image: UIImage(named: "bg_myinfo"))
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(-14 - onePixelWidth)
            make.leading.equalTo(view).offset(-15)
            make.trailing.equalTo(view).offset(15)
            make.bottom.equalTo(view).offset(14 + onePixelWidth)
            make.height.equalTo(imageView.snp.width).multipliedBy(338.0 / 750.0)
        }
        
        let titleLable2 = UILabel()
        
        
        let titleLabel = UILabel(font: .systemFont(ofSize: 18, weight: .bold), textColor: UIColor.e64919)
        titleLabel.text = "登录/注册"
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(view).offset(18)
            make.top.equalTo(view).offset(20)
        }
        
        let descriptionLabel = UILabel(font: .systemFont(ofSize: 16), textColor: UIColor.darkTextColor)
        descriptionLabel.text = "Hi，欢迎来到共享教育"
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
    }
    
    lazy var headImageView = UIImageView().then {
        $0.layer.cornerRadius = 27.5
        $0.layer.masksToBounds = true
    }
    
    lazy var teacherLogoImageView = UIImageView(image: UIImage(named: "icon_teacher"))
    
    lazy var nameLabel = UILabel(font: .systemFont(ofSize: 18, weight: .bold), textColor: .black)
    
    lazy var phoneLabel = UILabel(font: .systemFont(ofSize: 12), textColor: .lightTextColor)
    
    lazy var infoLabel = UILabel(font: .systemFont(ofSize: 12), textColor: .lightTextColor)
    
    lazy var infoButton = UIButton(backgroundImage: UIImage(named: "tag_student"))
    
    var courseControl: UIControl!
    
    var collectionControl: UIControl!
    
    var inviteButton: UIButton!
    
    var settingButton: UIButton!
    
    lazy var userInfoView = UIView().then { view in
        view.backgroundColor = .clear
        let imageView = UIImageView(image: UIImage(named: "bg_myinfo2"))
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(-14 - onePixelWidth)
            make.leading.equalTo(view).offset(-15)
            make.trailing.equalTo(view).offset(15)
            make.bottom.equalTo(view).offset(14 + onePixelWidth)
            make.height.equalTo(imageView.snp.width).multipliedBy(338.0 / 750.0)
        }
        
        view.addSubview(headImageView)
        view.addSubview(nameLabel)
        view.addSubview(teacherLogoImageView)
        view.addSubview(phoneLabel)
        view.addSubview(infoLabel)
        view.addSubview(infoButton)
        
        let myCourseControl = UIControl()
        courseControl = myCourseControl
        let courseImageView = UIImageView(image: UIImage(named: "icon_myclass"))
        let courseLabel = UILabel(font: UIFont.systemFont(ofSize: 13, weight: .medium), textColor: UIColor.darkTextColor)
        courseLabel.text = "我的课程"
        myCourseControl.addSubview(courseImageView)
        myCourseControl.addSubview(courseLabel)
        view.addSubview(myCourseControl)
        
        let myCollectionControl = UIControl()
        collectionControl = myCollectionControl
        let collectionImageView = UIImageView(image: UIImage(named: "icon_mytecher"))
        let collectionLabel = UILabel(font: UIFont.systemFont(ofSize: 13, weight: .medium), textColor: UIColor.darkTextColor)
        collectionLabel.text = "我的关注"
        myCollectionControl.addSubview(collectionImageView)
        myCollectionControl.addSubview(collectionLabel)
        view.addSubview(myCollectionControl)
        
        headImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(view).offset(17 + onePixelWidth)
            make.top.equalTo(view).offset(14)
            make.width.height.equalTo(55)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(13)
            make.leading.equalTo(headImageView.snp.trailing).offset(14 + onePixelWidth)
        }
        
        teacherLogoImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(nameLabel)
            make.leading.equalTo(nameLabel.snp.trailing).offset(5)
        }
        
        phoneLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(11)
        }
        
        infoLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(phoneLabel.snp.bottom).offset(10)
        }
        
        infoButton.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(14)
            make.trailing.equalTo(view)
        }
        
        courseImageView.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalTo(myCourseControl)
        }
        
        courseLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(courseImageView.snp.trailing).offset(9 + onePixelWidth)
            make.trailing.centerY.equalTo(myCourseControl)
        }
        
        myCourseControl.snp.makeConstraints { (make) in
            make.leading.equalTo(view).offset(60)
            make.bottom.equalTo(view).offset(-18)
        }
        
        collectionImageView.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalTo(myCollectionControl)
        }
        
        collectionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(collectionImageView.snp.trailing).offset(9 + onePixelWidth)
            make.trailing.centerY.equalTo(myCollectionControl)
        }
        
        myCollectionControl.snp.makeConstraints { (make) in
            make.trailing.equalTo(view).offset(-60)
            make.bottom.equalTo(view).offset(-18)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let bgImage = UIImage(named: "bg_my")!
        let bgImageView = UIImageView(image: bgImage)
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(self)
            make.height.equalTo(bgImageView.snp.width).multipliedBy(bgImage.size.height / bgImage.size.width)
        }
        
        let logoImageView = UIImageView(image: UIImage(named: "logo_my"))
        addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(14 + onePixelWidth)
            make.top.equalTo(self).offset(20 + actualStatusBarHeight)
        }
        
        settingButton = UIButton(image: UIImage(named: "icon_my_setting"))
        addSubview(settingButton)
        settingButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-18)
            make.top.equalTo(self).offset(actualStatusBarHeight + 28)
        }
        
        addSubview(loginControl)
        loginControl.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(actualStatusBarHeight + 67)
            make.leading.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15).priority(.high)
        }
        
        addSubview(userInfoView)
        userInfoView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(actualStatusBarHeight + 67)
            make.leading.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15).priority(.high)
        }
                
        let image: UIImage! = UIImage(named: "img_my")
        inviteButton = UIButton(backgroundImage: image)
        addSubview(inviteButton)
        inviteButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginControl.snp.bottom).offset(18)
            make.leading.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15).priority(.high)
            make.height.equalTo(inviteButton.snp.width).multipliedBy(image.size.height / image.size.width)
        }
        
        onLoginStatusChanged()
        
  //      NotificationCenter.default.addObserver(self, selector: #selector(onLoginStatusChanged(_:)), name: User.loginStatusDidChangeNotification, object: nil)
    }
    
    @objc func onLoginStatusChanged(_ notification: Notification? = nil) {
//        loginControl.isHidden = User.shared.isLogin
//        userInfoView.isHidden = !User.shared.isLogin
//        if User.shared.isLogin {
//            let userInfo = User.shared.userInfo!
////            headImageView.kf.setImage(with: <#T##Source?#>)
//            nameLabel.text = userInfo.name
//            phoneLabel.text = "1234567892"
//            switch userInfo.memberType {
//            case .teacher:
//                infoLabel.text = "北京大学附属二小 特级教师"
//                infoButton.setBackgroundImage(UIImage(named: "tag_teacher"), for: .normal)
//                teacherLogoImageView.isHidden = false
//            case .student:
//                let grade = ShareData.shared.findGrade(by: userInfo.gradeID)
//                if grade.id == 0 {
//                    infoLabel.text = "未设置"
//                } else {
//                    infoLabel.text = grade.name
//                }
//                infoButton.setBackgroundImage(UIImage(named: "tag_student"), for: .normal)
//                teacherLogoImageView.isHidden = true
//            case .none:
//                break
//            }
//        }
    }
    
}
