//
//  LoginViewController.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/27.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit
import AVFoundation
import PKHUD

class LoginViewController: UIViewController {
    
    lazy var titleLab: UILabel = {
        
        let titleLab = UILabel()
        titleLab.font = .systemFont(ofSize: 40)
        titleLab.textColor = .white
        titleLab.text = "登录"
        titleLab.textAlignment = .center
        return titleLab
    }()
    
    //登录
    lazy var loginView = UIView()
    lazy var usrName = UITextField()
    lazy var usrPwd = UITextField()
    //注册
    lazy var registeredView = UIView()
    lazy var registusrName = UITextField()
    lazy var registusrPwd = UITextField()
    lazy var passwordagain = UITextField()
    
    
    
    var player:AVPlayer?
    


    override func viewDidLoad() {
        super.viewDidLoad()
        Videomask()
        LoginView()
        RegisteredView()
        self.view.backgroundColor = bgColor
    }
    
    @objc func runLoopTheMovie(notification:NSNotification)
    {
        let playerItem = notification.object as! AVPlayerItem
        playerItem.seek(to: .zero, completionHandler: nil)
        player?.play()
        
    }
    
    @objc func fingerTapped(gestureRecognizer:UITapGestureRecognizer)
    {
        view.endEditing(true)
    }
    
    private func Videomask()
    {
        //视频
        let path = Bundle.main.path(forResource:"logo", ofType:"mp4")
        let url = NSURL.fileURL(withPath: path!)
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        player?.play()
        NotificationCenter.default.addObserver(self, selector: #selector(runLoopTheMovie(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        
        
        // 蒙板
        let maskImgView = UIImageView(image: UIImage(named: "black"))
        view.addSubview(maskImgView)
        maskImgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // 点击空白处收键盘
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(fingerTapped(gestureRecognizer:)))
        view.addGestureRecognizer(singleTap)
        
        //头
        view.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 260, height: 35))
        }
 
    }
    
    //登录
    private func LoginView()
    {
        //登录View
        view.addSubview(loginView)
        loginView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(90)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 260, height: 260))
        }

        // 请输入用户名
        let usrNameView = UIView()
        
        loginView.addSubview(usrNameView)
        usrNameView.snp.makeConstraints { (make) in
            
            make.top.equalTo(titleLab.snp.bottom).offset(90)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 260, height: 55))
        }
        InputboxView(userView: usrNameView, leftimage: "user", textField: usrName, placeholder: "请输入用户名")
        
        //请输入密码
        let usrPwdView = UIView()
        
        loginView.addSubview(usrPwdView)
        usrPwdView.snp.makeConstraints { (make) in
            
            make.top.equalTo(usrNameView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 260, height: 55))
        }
        InputboxView(userView: usrPwdView, leftimage: "password", textField: usrPwd, placeholder: "请输入密码")
        usrPwd.isSecureTextEntry = true
        
        //确认登陆
        let loginBtn = UIButton()
        
        loginView.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(usrPwdView.snp.bottom).offset(35)
            make.centerX.equalToSuperview()
            make.size.equalTo(usrPwdView)
        }
        loginBtn.setTitle("确定登录", for: .normal)
        loginBtn.setBackgroundImage(UIImage.init(named: "pink"), for: .normal)
        loginBtn.setBackgroundImage(UIImage.init(named: "pink"), for: .highlighted)
        loginBtn.addTarget(self, action: #selector(loginBtnClick(sender:)), for: .touchUpInside)
        
        
        //注册
        let registerBtn = UIButton()
        loginView.addSubview(registerBtn)
        registerBtn.snp.makeConstraints { (make) in
            make.left.equalTo(loginBtn.snp.left).offset(0)
            make.top.equalTo(loginBtn.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 80, height: 30))
        }
        registerBtn.setTitle("注册账号", for: .normal)
        registerBtn.titleLabel?.font = .systemFont(ofSize: 13)
        registerBtn.tintColor = .white
        registerBtn.addTarget(self, action: #selector(registerBtnClick(sender:)), for: .touchUpInside)
        
        
        usrName.text = "zhuzhen6"
        usrPwd.text = "123456"
    }
    
    
    //注册
    private func RegisteredView()
    {
        registeredView.isHidden = true
        //登录View
        view.addSubview(registeredView)
        registeredView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(90)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 260, height: 340))
        }

        // 请输入用户名
        let usrNameView = UIView()
        
        registeredView.addSubview(usrNameView)
        usrNameView.snp.makeConstraints { (make) in
            
            make.top.equalTo(titleLab.snp.bottom).offset(90)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 260, height: 55))
        }
        InputboxView(userView: usrNameView, leftimage: "user", textField: registusrName, placeholder: "请输入用户名")
        
        //请输入密码
        let usrPwdView = UIView()
        
        registeredView.addSubview(usrPwdView)
        usrPwdView.snp.makeConstraints { (make) in
            
            make.top.equalTo(usrNameView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 260, height: 55))
        }
        InputboxView(userView: usrPwdView, leftimage: "password", textField: registusrPwd, placeholder: "请输入密码")
        registusrPwd.isSecureTextEntry = true
        
        //再次输入密码
        let passwordagainView = UIView()
        
        registeredView.addSubview(passwordagainView)
        passwordagainView.snp.makeConstraints { (make) in
            
            make.top.equalTo(usrPwdView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 260, height: 55))
        }
        InputboxView(userView: passwordagainView, leftimage: "password", textField: passwordagain, placeholder: "再次输入密码")
        passwordagain.isSecureTextEntry = true
        
        //确认注册
        let registerBtn = UIButton()
        registeredView.addSubview(registerBtn)
        registerBtn.snp.makeConstraints { (make) in
            make.top.equalTo(passwordagainView.snp.bottom).offset(35)
            make.centerX.equalToSuperview()
            make.size.equalTo(passwordagainView)
        }
        registerBtn.setTitle("确定注册", for: .normal)
        registerBtn.setBackgroundImage(UIImage.init(named: "pink"), for: .normal)
        registerBtn.setBackgroundImage(UIImage.init(named: "pink"), for: .highlighted)
        registerBtn.addTarget(self, action: #selector(registeredBtnClick(sender:)), for: .touchUpInside)
        
        //登录
        let goLoginBtn = UIButton()
        registeredView.addSubview(goLoginBtn)
        goLoginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(registerBtn.snp.left).offset(0)
            make.top.equalTo(registerBtn.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 80, height: 30))
        }
        goLoginBtn.setTitle("立即登录", for: .normal)
        goLoginBtn.titleLabel?.font = .systemFont(ofSize: 13)
        goLoginBtn.tintColor = .white
        goLoginBtn.addTarget(self, action: #selector(loginClick(sender:)), for: .touchUpInside)
    }
    
    private func InputboxView(userView: UIView ,leftimage :NSString ,textField :UITextField ,placeholder :NSString)
    {
        let BgImgView = UIImageView(image: UIImage(named: "box"))
        userView.addSubview(BgImgView)
        BgImgView.snp.makeConstraints { (make) in
            make.edges.equalTo(userView)
        }
        
        let iconImgView1 = UIImageView(image: UIImage(named: leftimage as String))
        userView.addSubview(iconImgView1)
        iconImgView1.snp.makeConstraints { (make) in
            make.left.equalTo(userView.snp.left).offset(20)
            make.centerY.equalTo(userView)
            make.size.equalTo(CGSize(width: 15.5, height: 18))
        }
        
        userView.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(iconImgView1.snp.right).offset(10)
            make.right.equalTo(userView.snp.right).offset(-10)
            make.centerY.equalTo(userView)
            make.height.equalTo(20)
        }
        textField.font = .systemFont(ofSize: 15)
        textField.textColor = UIColor(hexString: "ffffff")
        textField.textAlignment = .left
        //字体颜色
        textField.attributedPlaceholder = NSAttributedString.init(string:placeholder as String, attributes: [
        NSAttributedString.Key.foregroundColor:UIColor(hexString: "e5e5e5")])
        textField.clearButtonMode = .whileEditing

    }
    
    @objc func registerBtnClick(sender:UIButton)
    {
        UIView.animate(withDuration: 0.2) {
            
            self.titleLab.text = "注册"
            self.registeredView.isHidden = false
            self.loginView.isHidden = true
        }
    }
    
    @objc func loginClick(sender:UIButton)
    {
        showLogin()
    }
    
    private func showLogin()
    {
        UIView.animate(withDuration: 0.2) {
            
            self.titleLab.text = "登录"
            self.registeredView.isHidden = true
            self.loginView.isHidden = false
        }
    }
    
    //登录请求
    @objc func loginBtnClick(sender:UIButton)
    {
        if usrName.text.isNilOrEmpty {
            
            HUD.flash(.labeledError(title: "错误", subtitle: "请输入帐号"), delay: 1)
            return
        }
        
        if usrPwd.text.isNilOrEmpty {
            
            HUD.flash(.labeledError(title: "错误", subtitle: "请输入密码"), delay: 1)
            return
        }
        
        var parameters = [String : Any]()
        parameters["username"] = usrName.text
        parameters["password"] = usrPwd.text

        HUD.show(.progress)
        Network.requestNOBaseModel(.login(parameters: parameters), model: BaseModel<User.UserModel>.self) { (data) in
            
            let model = data!
            if (model.errorCode == 0) {
                User.shared.account = self.usrName.text
                User.shared.setup(model: model.data!)
                HUD.flash(.success, delay: 1)
                self.dismiss(animated: true, completion: nil)
            }
            else
            {
                HUD.flash(.labeledError(title: "错误", subtitle: model.errorMsg), delay: 1)
            }

        }
        
        
    }
    
    //注册请求
    @objc func registeredBtnClick(sender:UIButton)
    {
        if registusrName.text.isNilOrEmpty {
            
            HUD.flash(.labeledError(title: "错误", subtitle: "请输入帐号"), delay: 1)
            return
        }
        
        if registusrPwd.text.isNilOrEmpty {
            
            HUD.flash(.labeledError(title: "错误", subtitle: "请输入密码"), delay: 1)
            return
        }
        
        if passwordagain.text.isNilOrEmpty {
            
            HUD.flash(.labeledError(title: "错误", subtitle: "请确认密码"), delay: 1)
            return
        }
        
        var parameters = [String : Any]()
        parameters["username"] = registusrName.text
        parameters["password"] = registusrPwd.text
        parameters["repassword"] = passwordagain.text

        HUD.show(.progress)
        Network.requestNOBaseModel(.register(parameters: parameters), model: BaseModel<User.UserModel>.self) { (data) in
            
            let model = data!
            if (model.errorCode == 0) {
                HUD.flash(.success, delay: 1)
                self.usrName.text = self.registusrName.text
                self.usrPwd.text = self.registusrPwd.text
                self.showLogin()
            }
            else
            {
                HUD.flash(.labeledError(title: "错误", subtitle: model.errorMsg), delay: 1)
            }

        }
        
        
    }
    
}
