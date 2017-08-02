//
//  HomeViewController.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/7/31.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import ReSwift
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {
    
    fileprivate let segmentControl = UISegmentedControl(frame: .zero)
    fileprivate let homeState = PublishSubject<HomeState>()
    fileprivate let latestNewsViewController = LatestNewsViewController()
    fileprivate let favoritesNewsViewController = FavoriteNewsViewController()
    let bag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        bind()
    }

    fileprivate func configUI() {
        view.addSubview(UIView(frame: .zero))
        
        navigationItem.titleView = segmentControl
        segmentControl.sizeToFit()
        segmentControl.addTarget(self, action: #selector(segmentClicked(segmentControl:)), for: .valueChanged)
        
        addChildViewController(latestNewsViewController)
        view.addSubview(latestNewsViewController.view)
        latestNewsViewController.view.isHidden = true
        latestNewsViewController.didMove(toParentViewController: self)
        
        addChildViewController(favoritesNewsViewController)
        view.addSubview(favoritesNewsViewController.view)
        favoritesNewsViewController.view.isHidden = true
        favoritesNewsViewController.didMove(toParentViewController: self)
    }

    fileprivate func bind() {
        homeState
            .map{ $0.segmentTitles }
            .distinctUntilChanged(==)
            .bind { [weak self] (titles: [String]) in
                guard let `self` = self else { return }
                self.segmentControl.removeAllSegments()
                titles.enumerated().forEach({ (offset: Int, element: String) in
                    self.segmentControl.insertSegment(withTitle: element, at: offset, animated: false)
                })
            }
            .disposed(by: bag)
        
        let segmentSelectedIndexState = homeState
            .map{ $0.segmentSelectedIndex }
            .share()
        
        segmentSelectedIndexState
            .distinctUntilChanged()
            .debug("segmentSelectedIndexState", trimOutput: true)
            .bind(onNext: { [weak self] (index: Int) in
                guard let `self` = self else { return }
                self.segmentControl.selectedSegmentIndex = index
            })
            .disposed(by: bag)
        
        segmentSelectedIndexState
            .distinctUntilChanged()
            .bind { [weak self] (i: Int) in
                guard let `self` = self else { return }
                let isLatestViewHidden = i != 0
                let isFavoritesViewHidden = i == 0
                self.latestNewsViewController.view.isHidden = isLatestViewHidden
                self.favoritesNewsViewController.view.isHidden = isFavoritesViewHidden
            }
            .disposed(by: bag)
        
        // MARK:  订阅store
        rx.viewWillAppear
            .bind { [weak self] (_) in
                guard let `self` = self else { return }
                appStore.subscribe(self, transform: { (sub: Subscription<AppState>) -> Subscription<HomeState> in
                    return sub.select({ (state: AppState) -> HomeState in
                        return state.homeState
                    })
                })
            }
            .disposed(by: bag)
        
        // MARK:  取消订阅store
        rx.viewWillDisappear
            .bind { [weak self] (_) in
                guard let `self` = self else { return }
                appStore.unsubscribe(self)
            }
            .disposed(by: bag)
        
        rx.viewDidAppear
            .map{ _ in RoutingAction(destination: .home) }
            .bind(onNext: appStore.dispatch)
            .disposed(by: bag)
    }
    
    @objc fileprivate func segmentClicked(segmentControl: UISegmentedControl) {
        let action = HomeSelectedSegmentAction(index: segmentControl.selectedSegmentIndex)
        appStore.dispatch(action)
    }
    
}

extension HomeViewController: StoreSubscriber {
    
    func newState(state: HomeState) {
        homeState.onNext(state)
    }
    
}
