//
//  FlickrAPIClient.swift
//  Glickr
//
//  Created by Ilter Cengiz on 22/05/16.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import Timberjack

class FlickrAPIClient {
    
    static private let manager: Manager = {
        let configuration = Timberjack.defaultSessionConfiguration()
        let manager = Manager(configuration: configuration)
        return manager
    }()
    
    static func recentPhotos(page: Int,
                             handler: (photos: [Photo], page: Int, pages: Int, total: Int) -> Void,
                             failure: (error: NSError?) -> Void = { _ in }) {
        manager.request(PhotosRouter.Recents(page: page)).responseObject {
            (response: Alamofire.Response<PagedPhotosResponse, NSError>) in
            if let photos = response.result.value?.photos,
               let page = response.result.value?.page,
               let pages = response.result.value?.pages,
               let total = response.result.value?.total {
                handler(photos: photos, page: page, pages: pages, total: total)
            } else {
                failure(error: response.result.error)
            }
        }
    }
    
}
