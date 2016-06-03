//
//  RecentsNavigationController.swift
//  Glickr
//
//  Created by Ilter Cengiz on 03/06/16.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

import UIKit

class RecentsNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let photosViewController = viewControllers.first where photosViewController is PhotosViewController {
            let pvc = photosViewController as! PhotosViewController
            pvc.dataSource = RecentsDataSource()
        }
    }
    
}
