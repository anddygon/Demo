//
//  LoadDataStatus.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/8/1.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import Foundation

enum LoadDataStatus<T> {
    case loading
    case loaded(T)
    case failure(Error)
}
