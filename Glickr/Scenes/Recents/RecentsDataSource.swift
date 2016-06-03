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
    
    func firstBatch(handler: FirstBatchHandler) {
        photos(0, handler: { (photos, range, hasNext) in
            handler(photos: photos, hasNext: hasNext)
        })
    }
    
    func nextBatch(handler: NextBatchHandler) {
        photos(currentPage + 1, handler: handler)
    }
    
    private func photos(page: Int, handler: NextBatchHandler) {
        FlickrAPIClient.recentPhotos(page, handler: { (photos, page, pages, total) in
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
