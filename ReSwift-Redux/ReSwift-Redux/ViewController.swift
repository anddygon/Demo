//
//  ViewController.swift
//  ReSwift-Redux
//
//  Created by xiaoP on 2017/7/25.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import ReSwift

class ViewController: BaseViewController, StoreSubscriber {

    let bag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    fileprivate func configUI() {
        let operations = OperationType.all
        let buttons = operations.map { (oper: OperationType)-> UIButton in
            let title = oper.rawValue.capitalized
            let btn = UIButton(type: .system)
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.backgroundColor = oper.displayColor
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            btn.rx.tap
                .map({ (_) -> Action in
                    return oper.action
                })
                .bind(onNext: mainStore.dispatch)
                .disposed(by: bag)
            return btn
        }
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.snp.makeConstraints { (make: ConstraintMaker) in
            make.center.equalToSuperview()
            make.width.equalTo(180)
            make.height.equalTo(40)
        }
        
        rx.methodInvoked(#selector(viewWillAppear(_:)))
            .bind { [weak self] (_) in
                guard let `self` = self else {
                    return
                }
                mainStore.subscribe(self)
            }
            .disposed(by: bag)
        
        rx.methodInvoked(#selector(viewWillDisappear(_:)))
            .bind { [weak self] (_) in
                guard let `self` = self else {
                    return
                }
                mainStore.unsubscribe(self)
            }
            .disposed(by: bag)
    }
    
    func newState(state: AppState) {
        title = "\(state.counter)"
    }
    
}

fileprivate enum OperationType: String {
    case increase
    case decrease
    
    static var all: [OperationType] {
        return [
            .increase,
            .decrease
        ]
    }
    
}

fileprivate extension OperationType {
    
    var displayColor: UIColor {
        switch self {
        case .increase:
            return .green
        case .decrease:
            return .red
        }
    }
    
    var action: Action {
        switch self {
        case .increase:
            return CounterActionIncrease()
        case .decrease:
            return CounterActionDecrease()
        }
    }
    
}
