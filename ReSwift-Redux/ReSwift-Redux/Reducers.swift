//
//  Reducers.swift
//  ReSwift-Redux
//
//  Created by xiaoP on 2017/7/25.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import Foundation
import ReSwift

func counterReducer(action: Action, state: AppState?)-> AppState {
    var state = state ?? AppState()
    
    switch action {
    case is CounterActionIncrease:
        state.counter += 1
    case is CounterActionDecrease:
        state.counter -= 1
    default:
        break
    }
    
    return state
}
