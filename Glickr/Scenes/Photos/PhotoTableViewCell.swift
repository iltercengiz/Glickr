//
//  PhotoCollectionViewCell.swift
//  Glickr
//
//  Created by Ilter Cengiz on 24/05/16.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        activityIndicator.startAnimating()
    }
    
    func configure(photo: Photo) {
        if let url = photo.url_l {
            photoImageView.af_setImageWithURL(url,
                                              placeholderImage: nil,
                                              filter: nil,
                                              progress: nil,
                                              progressQueue: dispatch_get_main_queue(),
                                              imageTransition: UIImageView.ImageTransition.CrossDissolve(0.25),
                                              runImageTransitionIfCached: true,
                                              completion: { [weak self] _ in
                self?.activityIndicator.stopAnimating()
            })
        }
    }
    
}
