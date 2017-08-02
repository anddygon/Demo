//
//  HomeReducer.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/7/31.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import ReSwift

func homeReducer(action: Action, state: HomeState?)-> HomeState {
    guard var state = state  else {
        //说明是app初始状态
        return HomeState(segmentTitles: ["Latest", "Favorites"], segmentSelectedIndex: 0)
    }
    switch action {
    case let homeAction as HomeSelectedSegmentAction:
        state.segmentSelectedIndex = homeAction.index
    default:
        break
    }
    return state
}
