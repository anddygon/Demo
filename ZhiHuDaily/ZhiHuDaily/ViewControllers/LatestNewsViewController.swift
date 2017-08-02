//
//  LatestNewsViewController.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/7/31.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import ReSwift
import RxDataSources

class LatestNewsViewController: BaseViewController {
    
    typealias NewsSection = SectionModel<Void, News>
    
    fileprivate let latestNewsState = PublishSubject<LatestNewsState>()
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)
    fileprivate let dataSource = RxTableViewSectionedReloadDataSource<NewsSection>()
    fileprivate let aiv = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    let bag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        bind()
    }
    
    fileprivate func configUI() {
        view.addSubview(tableView)
        tableView.tableFooterView = UIView()
        tableView.contentInset.top = 64
        tableView.register(NewsCell.self, forCellReuseIdentifier: "Cell")
        tableView.estimatedRowHeight = 44
        tableView.snp.makeConstraints { (make: ConstraintMaker) in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(aiv)
        aiv.hidesWhenStopped = true
        aiv.snp.makeConstraints { (make: ConstraintMaker) in
            make.center.equalToSuperview()
        }
        
        dataSource.configureCell = { (ds, tv, ip, news) in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell") as! NewsCell
            cell.fillData(news: news, favoriteButtonTapped: {
                let action = LatestNewsAction.ChangeFavorite(news: news)
                appStore.dispatch(action)
            })
            return cell
        }
        
        appStore.dispatch(LatestNewsAction.FetchNews.fetch(state:store:))
    }
    
    fileprivate func bind() {
        latestNewsState
            .map{ $0.news }
            .distinctUntilChanged(==)
            .map { (news: [News]) -> [NewsSection] in
                return [
                    NewsSection(model: (), items: news)
                ]
            }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        latestNewsState
            .map{ $0.showLoading }
            .distinctUntilChanged()
            .bind { [weak self] (isLoading: Bool) in
                guard let `self` = self else { return }
                isLoading ? self.aiv.startAnimating() : self.aiv.stopAnimating()
            }
            .disposed(by: bag)
        
        tableView.rx.modelSelected(News.self)
            .bind { (news: News) in
                let routingAction = RoutingAction(destination: .newsDetail(news: news))
                appStore.dispatch(routingAction)
            }
            .disposed(by: bag)
        
        // MARK: 订阅store
        rx.viewWillAppear
            .bind { [weak self] (_) in
                guard let `self` = self else { return }
                appStore.subscribe(self, transform: { (sub: Subscription<AppState>) -> Subscription<LatestNewsState> in
                    return sub.select({ (state: AppState) -> LatestNewsState in
                        return state.latestNewsState
                    })
                })
            }
            .disposed(by: bag)
        
        // MARK: 取消store订阅
        rx.viewWillDisappear
            .bind { [weak self] (_) in
                guard let `self` = self else { return }
                appStore.unsubscribe(self)
            }
            .disposed(by: bag)
    }

}

extension LatestNewsViewController: StoreSubscriber {
    
    func newState(state: LatestNewsState) {
        latestNewsState.onNext(state)
    }
    
}

