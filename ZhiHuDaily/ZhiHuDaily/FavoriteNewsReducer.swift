//
//  FavoriteNewsReducer.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/8/1.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import ReSwift

func favoriteNewsReducer(action: Action, state: FavoriteNewsState?)-> FavoriteNewsState {
    guard var state = state else {
        return FavoriteNewsState(news: [])
    }
    
    switch action {
    case let action as LatestNewsAction.ChangeFavorite:
        var actionNews = action.news
        actionNews.isFavorited = !actionNews.isFavorited
        if actionNews.isFavorited {
            state.news = state.news + [actionNews]
        } else {
            var arr = state.news
            let index = arr.index(where: { (news: News) -> Bool in
                news.weburl == actionNews.weburl
            })
            if let index = index {
                arr.remove(at: index)
            }
            state.news = arr
        }
        
    default:
        break
    }
    
    return state
}
