//
//  SearchDataSource.swift
//  Glickr
//
//  Created by Ilter Cengiz on 06/06/16.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

import UIKit

class SearchDataSource: NSObject, PhotosDataSource {
    
    private(set) var photos: [Photo] = []
    private(set) var hasNext = false
    private(set) var currentPage = 0
    var query = ""
    
    func firstBatch(handler: FirstBatchHandler) {
        photos(0, query: query) { (photos, range, hasNext) in
            handler(photos: photos, hasNext: hasNext)
        }
    }
    
    func nextBatch(handler: NextBatchHandler) {
        photos(currentPage + 1, query: query, handler: handler)
    }
    
    private func photos(page: Int, query: String, handler: NextBatchHandler) {
        FlickrAPIClient.searchPhotos(page, query: query, handler: { (photos, page, pages, total) in
            let range = self.photos.count..<(self.photos.count + photos.count)
            self.photos.appendContentsOf(photos)
            self.hasNext = (page != pages)
            self.currentPage = page
            handler(photos: photos, range: range, hasNext: self.hasNext)
        }) { (error) in
            handler(photos: [], range: 0..<0, hasNext: false)
        }
    }
    
}
