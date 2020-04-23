//
//  BookCell.swift
//  ZZXM
//
//  Created by TonghuiMac on 2020/4/23.
//  Copyright © 2020 TonghuiMac. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var authorLab: UILabel = {
        let authorLab = UILabel()
        authorLab.font = .systemFont(ofSize: 12)
        authorLab.textColor = .lightGray
        return authorLab
    }()

    lazy var dateLabel : UILabel = {
       
        let dateLabel = UILabel()
        dateLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textAlignment = .right
        return dateLabel
    }()
    
    lazy var img: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    lazy var titleLabel : UILabel = {
       
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 16)
        return titleLabel
    }()
    
    lazy var descLabel : UILabel = {
       
        let descLabel = UILabel()
        descLabel.textColor = .gray
        descLabel.font = .systemFont(ofSize: 13)
        descLabel.numberOfLines = 3
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
        contentView.addSubview(authorLab)
        contentView.addSubview(dateLabel)
        contentView.addSubview(img)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(collectionBtn)
        
        authorLab.snp.makeConstraints { (maker) in
            maker.left.top.equalToSuperview().offset(10)
            maker.width.equalTo(200)
            maker.height.equalTo(20)
        }
        
        dateLabel.snp.makeConstraints { (maker) in
            maker.top.width.height.equalTo(authorLab)
            maker.right.equalToSuperview().offset(-10)
        }
        
        img.snp.makeConstraints { (maker) in
            maker.left.equalTo(authorLab)
            maker.top.equalTo(authorLab.snp.bottom).offset(10)
            maker.width.equalToSuperview().multipliedBy(0.33)
            maker.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(img.snp.top)
            maker.right.equalTo(dateLabel)
            maker.left.equalTo(img.snp.right).offset(10)
        }
        
        descLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleLabel.snp.bottom).offset(2)
            maker.left.right.equalTo(titleLabel)
            maker.bottom.equalTo(img.snp.bottom)
        }
        
        typeLabel.snp.makeConstraints { (maker) in
            maker.left.height.width.equalTo(authorLab)
            maker.top.equalTo(img.snp.bottom).offset(10)
            maker.bottom.equalToSuperview().offset(-10)
        }
        
        
        collectionBtn.snp.makeConstraints { (maker) in
            maker.right.bottom.equalToSuperview().offset(-10)
            maker.width.height.equalTo(25)
        }
    }
    
    var viewModel: BookDetailModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            authorLab.text =  viewModel.author
            dateLabel.text = !viewModel.niceDate!.isEmpty  ? viewModel.niceDate : viewModel.niceShareDate
            
            titleLabel.text = viewModel.title
            descLabel.text = viewModel.desc
            typeLabel.text = viewModel.superChapterName
           // img.kf.setImage(with: URL(string: viewModel.envelopePic!))
            img.kf.setImage(with: URL(string: viewModel.envelopePic!),
            placeholder: UIImage(named: "normal_placeholder_h"),
            options:[.transition(.fade(0.5))])
            let image: UIImage! = UIImage(named: "lujing")
            collectionBtn.setBackgroundImage(image, for: .normal)
        }
    }

}
