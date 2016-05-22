//
//  Photo.swift
//  Glickr
//
//  Created by Ilter Cengiz on 22/05/16.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

import Foundation
import ObjectMapper

class Photo: Mappable {
    
    var id: String?
    var owner: String?
    var title: String?
    var isPublic: Bool?
    var dateTaken: NSDate?
    var ownername: String?
    var media: String?
    var url_l: NSURL?
    var height_l: Int?
    var width_l: Int?
    
    required init?(_ map: Map) {
        if map["url_l"].value() == nil {
            return nil
        }
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        owner <- map["owner"]
        title <- map["title"]
        isPublic <- (map["ispublic"], TransformOf<Bool, Int>(fromJSON: { (value: Int?) -> Bool? in
            guard let intValue = value else { return nil }
            return Bool(intValue)
        }, toJSON: { (value: Bool?) -> Int? in
            guard let boolValue = value else { return nil }
            return Int(boolValue)
        }))
        dateTaken <- (map["datetaken"], DateTransform())
        ownername <- map["ownername"]
        media <- map["media"]
        url_l <- (map["url_l"], URLTransform())
        let IntTransform = TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in
            guard let stringValue = value else { return nil }
            return Int(stringValue)
        }) { (value: Int?) -> String? in
            guard let intValue = value else { return nil }
            return String(intValue)
        }
        height_l <- (map["height_l"], IntTransform)
        width_l <- (map["width_l"], IntTransform)
    }
    
}

//    {
//        "id": "26568057694",
//        "owner": "37911735@N00",
//        "secret": "2691053736",
//        "server": "7255",
//        "farm": 8,
//        "title": "Best burger I had in long while! #burger #bbq #nomnom",
//        "ispublic": 1,
//        "isfriend": 0,
//        "isfamily": 0,
//        "datetaken": "2016-05-22 19:01:20",
//        "datetakengranularity": 0,
//        "datetakenunknown": "1",
//        "ownername": "iris het viris",
//        "media": "photo",
//        "media_status": "ready",
//        "url_l": "https://farm8.staticflickr.com/7255/26568057694_2691053736_b.jpg",
//        "height_l": "1024",
//        "width_l": "1024"
//    }
