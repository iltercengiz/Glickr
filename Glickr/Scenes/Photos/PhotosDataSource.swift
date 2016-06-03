//
//  PhotosDataSource.swift
//  Glickr
//
//  Created by Ilter Cengiz on 03/06/16.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

import UIKit

protocol PhotosDataSource {
    
    var photos: [Photo] { get }
    var hasNext: Bool { get }
    var currentPage: Int { get }
    
    func photos(page: Int, handler: (photos: [Photo], hasNext: Bool) -> Void)
    
}
