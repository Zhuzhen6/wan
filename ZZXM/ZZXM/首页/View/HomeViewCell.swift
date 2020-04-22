//
//  HomeViewCell.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/17.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    override var frame: CGRect{
        didSet {
            var newFrame = frame
            newFrame.origin.x += 10
            newFrame.size.width -= 2 * 10
            newFrame.origin.y += 10
            newFrame.size.height -= 10
            super.frame = newFrame
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var authorLabel : UILabel = {
       
        let authorLabel = UILabel()
        authorLabel.textColor = .gray
        authorLabel.font = .systemFont(ofSize: 12)
        return authorLabel
    }()
    
    lazy var dateLabel : UILabel = {
       
        let dateLabel = UILabel()
        dateLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textAlignment = .right
        return dateLabel
    }()
    
    lazy var descLabel : UILabel = {
       
        let descLabel = UILabel()
        descLabel.textColor = .black
        descLabel.font = .systemFont(ofSize: 15)
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    lazy var typeLabel : UILabel = {
       
        let typeLabel = UILabel()
        typeLabel.textColor = .gray
        typeLabel.font = .systemFont(ofSize: 12)
        return typeLabel
    }()

    lazy var collectionBtn : UIButton = {
       
        let collectionBtn = UIButton()
        let image: UIImage! = UIImage(named: "lujing")
        collectionBtn.setBackgroundImage(image, for: .normal)
        return collectionBtn
    }()
    
    func setupUI()
    {
        contentView.addSubview(authorLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(collectionBtn)
        authorLabel.snp.makeConstraints { (maker) in
            
            maker.left.top.equalToSuperview().offset(15)
            maker.width.equalTo(150)
            maker.height.equalTo(20)
        }
        
        
        dateLabel.snp.makeConstraints { (maker) in
            maker.top.height.equalTo(authorLabel)
            maker.right.equalToSuperview().offset(-15)
            maker.left.equalTo(authorLabel.snp.right).offset(15)

        }
        
        
        descLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(authorLabel.snp.bottom).offset(15)
            maker.left.equalTo(authorLabel)
            maker.right.equalTo(dateLabel)
            maker.height.equalTo(50)
        }

        
        typeLabel.snp.makeConstraints { (maker) in
            maker.left.height.width.equalTo(authorLabel)
            maker.top.equalTo(descLabel.snp.bottom).offset(15)
            maker.bottom.equalToSuperview().offset(-10)
        }
        
        
        collectionBtn.snp.makeConstraints { (maker) in
            maker.right.bottom.equalToSuperview().offset(-15)
            maker.width.height.equalTo(25)
        }
    }
    
    var viewModel: ArticleDetailModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            authorLabel.text = !viewModel.author!.isEmpty ? viewModel.author : viewModel.chapterName
            dateLabel.text = !viewModel.niceDate!.isEmpty  ? viewModel.niceDate : viewModel.niceShareDate
            
            descLabel.text = viewModel.title
            typeLabel.text = viewModel.superChapterName

            let image: UIImage! = UIImage(named: "lujing")
            collectionBtn.setBackgroundImage(image, for: .normal)
        }
    }
}

