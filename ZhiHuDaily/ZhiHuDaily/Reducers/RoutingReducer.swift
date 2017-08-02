//
//  RoutingReducer.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/7/31.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import ReSwift

func routingReducer(action: Action, state: RoutingState?)-> RoutingState {
    guard var state = state else {
        return RoutingState(navigationState: .home)
    }
    
    switch action {
    case let routingAction as RoutingAction:
        state.navigationState = routingAction.destination
    default:
        break
    }
    
    return state
}
