//
//  PagedPhotosResponse.swift
//  Glickr
//
//  Created by Ilter Cengiz on 22/05/16.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

import Foundation
import ObjectMapper

class PagedPhotosResponse: Response {
    
    var page: Int?
    var pages: Int?
    var perpage: Int?
    var total: Int?
    var photo: [Photo]?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        page <- map["page"]
        pages <- map["pages"]
        perpage <- map["perpage"]
        total <- (map["total"], TransformOf<Int, AnyObject>(fromJSON: { (value: AnyObject?) -> Int? in
            if let intValue = value as? Int {
                return intValue
            } else if let stringValue = value as? String {
                return Int(stringValue)
            }
            return nil
        }, toJSON: { (value: Int?) -> AnyObject? in
            guard let intValue = value else { return nil }
            return String(intValue)
        }))
        photo <- map["photo"]
    }
    
}

//    {
//        "photos": {
//            "page": 1,
//            "pages": 10,
//            "perpage": 100,
//            "total": 1000, // Can be string in some responses
//            "photo": []
//        },
//        "stat": "ok"
//    }
