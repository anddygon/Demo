//
//  News.swift
//  ZhiHuDaily
//
//  Created by xiaoP on 2017/8/1.
//  Copyright © 2017年 Chicv. All rights reserved.
//

import Foundation
import ObjectMapper

struct News: Mappable, Equatable {
    var name = ""
    var weburl = ""
    var isFavorited = false
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        weburl <- map["weburl"]
    }
    
    static func ==(l: News, r: News)-> Bool {
        return (
            l.weburl == r.weburl &&
            l.isFavorited == r.isFavorited &&
            l.name == r.name
        )
        
    }
    
}
