//
//  AppRouter.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/7/31.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import ReSwift

enum RoutingDestination: Equatable {
    case home
    case newsDetail(news: News)
    
    static func ==(l: RoutingDestination, r: RoutingDestination)-> Bool {
        switch (l, r) {
        case (.home, .home):
            return true
        case (.newsDetail, .newsDetail):
            return true
        case (.home, .newsDetail):
            return false
        case (.newsDetail, .home):
            return false
        }
    }
}

final class AppRouter {
    
    let navigationController: UINavigationController
    

    init(window: UIWindow) {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        self.navigationController = navigationController
        
        appStore.subscribe(self) { (sub: Subscription<AppState>) -> Subscription<RoutingState> in
            return sub.select({ (state: AppState) -> RoutingState in
                return state.routingState
            })
        }
    }
 
    deinit {
        appStore.unsubscribe(self)
    }
    
}

extension AppRouter: StoreSubscriber {
    
    func newState(state: RoutingState) {
        let newVc = viewController(forRoutingState: state.navigationState)
        let newVcType = type(of: newVc)
        if let currentVc = navigationController.topViewController {
            let currentVcType = type(of: currentVc)
            if String(describing: newVcType) == String(describing: currentVcType) {
                return
            }
        }
        let animated = navigationController.topViewController != nil
        navigationController.pushViewController(newVc, animated: animated)
    }
    
    fileprivate func viewController(forRoutingState destination: RoutingDestination)-> UIViewController {
        switch destination {
        case .home:
            return HomeViewController()
        case let .newsDetail(news):
            return NewsDetailViewController(news: news)
        }
    }
    
}
