//
//  BaseViewController.swift
//  StackView
//
//  Created by xiaoP on 2017/7/24.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    required init?(coder aDecoder: NSCoder) {
        fatalError("not implement")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
}
