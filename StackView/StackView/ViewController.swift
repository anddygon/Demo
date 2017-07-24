//
//  ViewController.swift
//  StackView
//
//  Created by xiaoP on 2017/7/24.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import UIKit
import SnapKit
import OAStackView
import RxSwift
import RxCocoa

class ViewController: BaseViewController {
    
    fileprivate let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    fileprivate func configUI() {
        let l1: UILabel = UILabel(frame: .zero)
        l1.text = "Label 1"
        l1.backgroundColor = .red
        l1.textColor = .white
        
        let l2: UILabel = UILabel(frame: .zero)
        l2.text = "Label 2"
        l2.backgroundColor = .green
        l2.textColor = .white
        
        let stackView = OAStackView(arrangedSubviews: [l1, l2])
        stackView.axis = .horizontal
        view.addSubview(stackView)
        stackView.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.right.equalToSuperview()
            make.top.equalTo(20)
            make.height.equalTo(60)
        }
        
        // MARK: Distribution
        let disTitles = OAStackViewDistribution.all.map{ $0.title }
        let disSegment = UISegmentedControl(items: disTitles)
        disSegment.selectedSegmentIndex = 0
        view.addSubview(disSegment)
        disSegment.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        disSegment.rx.value
            .map(OAStackViewDistribution.init(rawValue:))
            .bind(onNext: { (dis: OAStackViewDistribution?) in
                guard let dis = dis else {
                    return
                }
                stackView.distribution = dis
            })
            .disposed(by: bag)
        
        let disLabel = UILabel(frame: .zero)
        disLabel.text = "Distribution"
        view.addSubview(disLabel)
        disLabel.snp.makeConstraints { (make: ConstraintMaker) in
            make.centerX.equalTo(disSegment)
            make.bottom.equalTo(disSegment.snp.top)
        }
        
        // MARK: Alignment
        let alignTitles = OAStackViewAlignment.all.map{ $0.title }
        let alignSegment = UISegmentedControl(items: alignTitles)
        alignSegment.selectedSegmentIndex = 0
        view.addSubview(alignSegment)
        alignSegment.snp.makeConstraints { (make: ConstraintMaker) in
            make.left.right.height.equalTo(disSegment)
            make.bottom.equalTo(disLabel.snp.top)
        }
        alignSegment.rx.value
            .map(OAStackViewAlignment.init(rawValue: ))
            .bind { (align: OAStackViewAlignment?) in
                guard let align = align else {
                    return
                }
                stackView.alignment = align
            }
            .disposed(by: bag)

        let alignLabel = UILabel(frame: .zero)
        alignLabel.text = "Align"
        view.addSubview(alignLabel)
        alignLabel.snp.makeConstraints { (make: ConstraintMaker) in
            make.centerX.equalTo(alignSegment)
            make.bottom.equalTo(alignSegment.snp.top)
        }
    }
    
}

fileprivate extension OAStackViewDistribution {
    
    var title: String {
        switch self {
        case .fill:
            return "Fill"
        case .fillEqually:
            return "FillEqually"
        case .fillProportionally:
            return "FillProportionally"
        case .equalCentering:
            return "EqualCentering"
        case .equalSpacing:
            return "EqualSpacing"
        }
    }
    
    static var all: [OAStackViewDistribution] {
        return [
            .fill,
            .fillEqually,
            .fillProportionally,
            .equalCentering,
            .equalSpacing
        ]
    }
    
}

fileprivate extension OAStackViewAlignment {
    
    var title: String {
        switch self {
        case .baseline:
            return "Baseline"
        case .center:
            return "Center"
        case .fill:
            return "Fill"
        case .firstBaseline:
            return "FirstBaseline"
        case .leading:
            return "Leading"
        case .trailing:
            return "Trailing"
        }
    }
    
    static var all: [OAStackViewAlignment] {
        return [
            .baseline,
            .center,
            .fill,
            .firstBaseline,
            .leading,
            .trailing
        ]
    }
    
}
