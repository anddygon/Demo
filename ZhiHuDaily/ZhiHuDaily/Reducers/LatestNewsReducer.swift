//
//  LatestReducer.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/8/1.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import ReSwift

func latestNewsReducer(action: Action, state: LatestNewsState?)-> LatestNewsState {
    guard var state = state else {
        return LatestNewsState(news: [], showLoading: false)
    }
    
    switch action {
    case let fetchNewsAction as LatestNewsAction.FetchNews:
        switch fetchNewsAction.loadStatus {
        case let .loaded(news):
            state.showLoading = false
            state.news = news
        case .failure:
            state.showLoading = false
        case .loading:
            state.showLoading = true
        }
    case let action as LatestNewsAction.ChangeFavorite:
        var newsArr = state.news
        let index = newsArr.index(where: { (news: News) -> Bool in
            news.weburl == action.news.weburl
        })
        if let index = index {
            newsArr[index].isFavorited = !newsArr[index].isFavorited
        }
        state.news = newsArr
    default:
        break
    }
    
    return state
}
