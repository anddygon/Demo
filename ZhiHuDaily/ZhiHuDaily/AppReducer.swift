//
//  AppReducer.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/7/31.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import ReSwift

/* 
    主reducer将aciton分发给所有的子reducer
    子reducer根据action 生成新的子state
    主reducer将所有的子reducer生成的新state汇总生成新的总state（AppState）
 */

/// 主Reducer
///
/// - Parameters:
///   - action: action
///   - state: app当前状态 nil 代表app初始 否则根据action迭代出新的state
/// - Returns: 新的app状态
func appReducer(action: Action, state: AppState?)-> AppState {
    let routingState = routingReducer(action: action, state: state?.routingState)
    let homeState = homeReducer(action: action, state: state?.homeState)
    let latestNewsState = latestNewsReducer(action: action, state: state?.latestNewsState)
    let favoriteNewsState = favoriteNewsReducer(action: action, state: state?.favoriteNewsState)
    return AppState(
        routingState: routingState,
        homeState: homeState,
        latestNewsState: latestNewsState,
        favoriteNewsState: favoriteNewsState
    )
}
