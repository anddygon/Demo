//
//  NewsCell.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/8/1.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import UIKit
import SnapKit

class NewsCell: BaseTableViewCell {
    let titleLabel = UILabel(frame: .zero)
    let favoriteButton = UIButton(type: .custom)
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(favoriteButton)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { (make: ConstraintMaker) in
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(favoriteButton.snp.left).offset(8)
        }
        
        favoriteButton.setTitle("♥︎", for: .normal)
        favoriteButton.setTitleColor(.gray, for: .normal)
        favoriteButton.setTitleColor(.red, for: .selected)
        favoriteButton.snp.makeConstraints { (make: ConstraintMaker) in
            make.right.equalToSuperview().offset(-16)            
            make.centerY.equalToSuperview()
            make.width.equalTo(30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillData(news: News, favoriteButtonTapped tapped: @escaping (()->Void)) {
        titleLabel.text = news.name
        favoriteButton.isSelected = news.isFavorited
        
        favoriteButton.rx.tap
            .bind(onNext: tapped)
            .disposed(by: bag)
    }
    
}
