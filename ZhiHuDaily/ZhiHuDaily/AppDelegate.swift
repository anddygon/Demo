//
//  AppDelegate.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/7/28.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import UIKit
import ReSwift
import RxSwift

let appStore: Store<AppState> = Store(reducer: appReducer, state: nil)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    fileprivate(set) var appRouter: AppRouter?
    fileprivate let routingState = PublishSubject<RoutingState>()
    let bag = DisposeBag()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let frame = UIScreen.main.bounds
        let window = UIWindow(frame: frame)
        window.makeKeyAndVisible()
        window.tintColor = .black
        self.window = window
        self.appRouter = AppRouter(window: window)
        
        return true
    }


}
