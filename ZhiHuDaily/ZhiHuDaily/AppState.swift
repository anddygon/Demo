//
//  AppState.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/7/31.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import ReSwift

struct AppState: StateType {
    let routingState: RoutingState
    let homeState: HomeState
    let latestNewsState: LatestNewsState
    let favoriteNewsState: FavoriteNewsState
}
