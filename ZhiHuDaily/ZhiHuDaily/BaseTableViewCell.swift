//
//  BaseTableViewCell.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/8/1.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import UIKit
import RxSwift

class BaseTableViewCell: UITableViewCell {
    
    private(set) var bag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }

}
