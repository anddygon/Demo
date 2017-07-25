//
//  BaseViewController.swift
//  ReSwift-Redux
//
//  Created by xiaoP on 2017/7/25.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

   

}
