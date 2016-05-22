//
//  Response.swift
//  Glickr
//
//  Created by Ilter Cengiz on 22/05/16.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

import Foundation
import ObjectMapper

class Response: Mappable {
    
    var stat: Bool?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        stat <- (map["stat"], TransformOf<Bool, String>(fromJSON: { (value: String?) -> Bool? in
            guard let stringValue = value else { return nil }
            return stringValue == "ok"
        }, toJSON: { (value: Bool?) -> String? in
            guard let boolValue = value else { return nil }
            return boolValue ? "ok" : nil
        }))
    }
    
}

//    {
//        <Some other data>
//        "stat": "ok"
//    }
