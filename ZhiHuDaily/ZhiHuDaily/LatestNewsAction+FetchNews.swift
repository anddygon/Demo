//
//  LatestNewsAction.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/8/1.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import ReSwift
import Alamofire
import ObjectMapper

extension LatestNewsAction {
    
    struct FetchNews: Action {
        var loadStatus: LoadDataStatus<[News]>
    }
    
}

extension LatestNewsAction.FetchNews {
    
    // MARK: 从server获取news
    static func fetch(state: AppState, store: Store<AppState>)-> LatestNewsAction.FetchNews? {
        
        let url = URL(string: "https://www.popjulia.com/rest/productindex")!
        request(url)
            .responseJSON { (response: DataResponse<Any>) in
                switch response.result {
                case let .success(v):
                    let jsonList = (v as AnyObject).value(forKeyPath: "list")
                    let news = Mapper<News>().mapArray(JSONObject: jsonList) ?? []
                    let loadedAction = LatestNewsAction.FetchNews(loadStatus: LoadDataStatus<[News]>.loaded(news))
                    store.dispatch(loadedAction)
                case let .failure(e):
                    let failureAction = LatestNewsAction.FetchNews(loadStatus: LoadDataStatus<[News]>.failure(e))
                    store.dispatch(failureAction)
                }
        }
        
        return LatestNewsAction.FetchNews(loadStatus: LoadDataStatus<[News]>.loading)
    }
    
}

extension DataResponse {
    
    
    
}
