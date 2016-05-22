//
//  ParameterParser.swift
//  Glickr
//
//  Created by Ilter Cengiz on 22/05/16.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

import Foundation
import Alamofire

private let HostURL = NSURL(string: "https://api.flickr.com/services/rest/")!
private let APIKey = "d3a68da120b480a1694db7cf675fcd43"

extension URLRequestConvertible {
    
    func requestWith(parameters: [String: AnyObject]) -> NSMutableURLRequest {
        var expandedParameters: [String: AnyObject] = [
            "format": "json",
            "nojsoncallback": 1,
            "api_key": APIKey
        ]
        for (key, value) in parameters {
            expandedParameters[key] = value
        }
        let (request, _) = Alamofire.ParameterEncoding.JSON.encode(NSMutableURLRequest(URL: HostURL), parameters: expandedParameters)
        return request
    }
    
}
