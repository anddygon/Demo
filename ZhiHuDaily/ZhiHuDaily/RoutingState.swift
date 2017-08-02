//
//  RoutingState.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/7/31.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import ReSwift

struct RoutingState: StateType {
    var navigationState: RoutingDestination
    
    init(navigationState: RoutingDestination) {
        self.navigationState = navigationState
    }
}
