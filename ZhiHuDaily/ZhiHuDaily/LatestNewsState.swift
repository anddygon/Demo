//
//  LatestNewsState.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/8/1.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import ReSwift

struct LatestNewsState: StateType {
    var news: [News]
    var showLoading: Bool
}
