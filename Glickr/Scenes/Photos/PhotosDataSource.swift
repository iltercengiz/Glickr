//
//  PhotosDataSource.swift
//  Glickr
//
//  Created by Ilter Cengiz on 03/06/16.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

import UIKit

typealias FirstBatchHandler = (photos: [Photo], hasNext: Bool) -> Void
typealias NextBatchHandler = (photos: [Photo], range: Range<Int>, hasNext: Bool) -> Void

protocol PhotosDataSource {
    
    var photos: [Photo] { get }
    var hasNext: Bool { get }
    var currentPage: Int { get }
    
    func firstBatch(handler: FirstBatchHandler)
    func nextBatch(handler: NextBatchHandler)
    
}
