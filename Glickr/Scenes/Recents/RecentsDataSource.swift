//
//  RecentsInteractor.swift
//  Glickr
//
//  Created by Ilter Cengiz on 24/05/16.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

import UIKit

class RecentsDataSource: NSObject, PhotosDataSource {
    
    private(set) var photos: [Photo] = []
    private(set) var hasNext = false
    private(set) var currentPage = 0
    
    func photos(page: Int, handler: (photos: [Photo], hasNext: Bool) -> Void) {
        FlickrAPIClient.recentPhotos(page, handler: { (photos, page, pages, total) in
            self.photos = photos
            self.hasNext = (page == pages)
            self.currentPage = page
            handler(photos: self.photos, hasNext: self.hasNext)
        }) { (error) in
            handler(photos: [], hasNext: false)
        }
    }
    
}
