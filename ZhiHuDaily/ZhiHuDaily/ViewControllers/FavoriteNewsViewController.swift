//
//  FavoriteNewsViewController.swift
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

class FavoriteNewsViewController: BaseViewController {
    
    typealias NewsSection = SectionModel<Void, News>
    
    fileprivate let favoriteNewsState = PublishSubject<FavoriteNewsState>()
    fileprivate let tableView = UITableView(frame: .zero, style: .plain)
    fileprivate let dataSource = RxTableViewSectionedReloadDataSource<NewsSection>()
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
        
        dataSource.configureCell = { (ds, tv, ip, news) in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell") as! NewsCell
            cell.fillData(news: news, favoriteButtonTapped: {
                let action = LatestNewsAction.ChangeFavorite(news: news)
                appStore.dispatch(action)
            })
            return cell
        }
    }
    
    fileprivate func bind() {
        favoriteNewsState
            .map{ $0.news }
            .map { (news: [News]) -> [NewsSection] in
                return [
                    NewsSection(model: (), items: news)
                ]
            }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        tableView.rx.modelSelected(News.self)
            .bind { (news: News) in
                let routingAction = RoutingAction(destination: .newsDetail(news: news))
                appStore.dispatch(routingAction)
            }
            .disposed(by: bag)
        
        rx.viewWillAppear
            .bind { [weak self] (_) in
                guard let `self` = self else { return }
                appStore.subscribe(self, transform: { (sub: Subscription<AppState>) -> Subscription<FavoriteNewsState> in
                    return sub.select({ (state: AppState) -> FavoriteNewsState in
                        return state.favoriteNewsState
                    })
                })
            }
            .disposed(by: bag)
        
        rx.viewWillDisappear
            .bind { [weak self] (_) in
                guard let `self` = self else { return }
                appStore.unsubscribe(self)
            }
            .disposed(by: bag)
    }
    
}

extension FavoriteNewsViewController: StoreSubscriber {
    
    func newState(state: FavoriteNewsState) {
        favoriteNewsState.onNext(state)
    }
    
}
