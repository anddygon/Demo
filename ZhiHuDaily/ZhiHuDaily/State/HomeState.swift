//
//  HomeState.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/7/31.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import ReSwift

struct HomeState: StateType, CustomStringConvertible {
    var segmentTitles: [String]
    var segmentSelectedIndex: Int
    var description: String {
        return "segment titles: \(segmentTitles) --- segment selected index: \(segmentSelectedIndex)"
    }
}
