//
//  PhotosResponse.swift
//  Glickr
//
//  Created by Ilter Cengiz on 24/05/16.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

import Foundation
import ObjectMapper

class PhotosResponse: Response {
    
    var photos: PagedPhotosResponse?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        photos <- map["photos"]
    }
    
}

//    {
//        "photos": <PagedPhotosResponse>,
//        "stat": "ok"
//    }
