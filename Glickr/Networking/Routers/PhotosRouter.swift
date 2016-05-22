//
//  PhotosRouter.swift
//  Glickr
//
//  Created by Ilter Cengiz on 22/05/16.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

private let extras = "owner_name,date_taken,media,url_l"

enum PhotosRouter: URLRequestConvertible {
    
    case Recents
    case Search(query: String)
    
    var URLRequest: NSMutableURLRequest {
        var method: String {
            switch self {
            case .Recents:
                return "flickr.photos.getRecent"
            case .Search:
                return "flickr.photos.search"
            }
        }
        var parameters: [String: AnyObject] {
            switch self {
            case .Recents:
                return [
                    "method": method,
                    "extras": extras
                ]
            case .Search(let query):
                return [
                    "method": method,
                    "extras": extras,
                    "text": query
                ]
            }
        }
        let request = requestWith(parameters)
        return request
    }
    
}
