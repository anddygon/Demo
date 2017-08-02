//
//  BaseViewController.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/7/31.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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

extension Reactive where Base: UIViewController {
    
    var viewWillAppear: Observable<Void> {
        return base.rx.methodInvoked(#selector(Base.viewWillAppear(_:)))
            .map{ _ in }
    }
    
    var viewDidAppear: Observable<Void> {
        return base.rx.methodInvoked(#selector(Base.viewDidAppear(_:)))
            .map{ _ in }
    }
    
    var viewWillDisappear: Observable<Void> {
        return base.rx.methodInvoked(#selector(Base.viewWillDisappear(_:)))
            .map{ _ in }
    }
    
}
