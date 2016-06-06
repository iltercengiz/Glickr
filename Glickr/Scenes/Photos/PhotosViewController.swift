//
//  RecentsViewController.swift
//  Glickr
//
//  Created by Ilter Cengiz on 24/05/16.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

import UIKit

enum SectionType: Int {
    case Photo = 0
    case Loading = 1
}

class PhotosViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingView: UIStackView!
    var dataSource: PhotosDataSource? {
        didSet {
            refreshPhotos()
        }
    }
    private var cellHeights: [NSIndexPath: CGFloat] = [:]
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Public functions
    
    func refreshPhotos() {
        dataSource?.firstBatch() { [weak self] (photos, hasNext) in
            self?.tableView.reloadData()
            self?.loadingView.hidden = true
            self?.removeLoadingCellIfNeeded()
        }
    }
    
    // MARK: - Private functions
    
    private func fetchNextPhotos() {
        dataSource?.nextBatch() { [weak self] (photos, range, hasNext) in
            let indexPaths = range.map({ NSIndexPath(forRow: $0, inSection: SectionType.Photo.rawValue) })
            self?.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
            self?.removeLoadingCellIfNeeded()
        }
    }
    
    private func removeLoadingCellIfNeeded() {
        guard tableView.numberOfRowsInSection(SectionType.Loading.rawValue) > 0,
            let hasNext = dataSource?.hasNext where !hasNext else {
            return
        }
        tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: SectionType.Loading.rawValue)], withRowAnimation: .Fade)
    }
    
}

extension PhotosViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == SectionType.Photo.rawValue {
            let cell = tableView.dequeueReusableCellWithIdentifier(String(PhotoTableViewCell), forIndexPath: indexPath) as! PhotoTableViewCell
            cell.configure(dataSource!.photos[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("LoadingTableViewCell", forIndexPath: indexPath)
            return cell
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = dataSource else {
            return 0
        }
        if section == SectionType.Photo.rawValue {
            return dataSource.photos.count
        } else if section == SectionType.Loading.rawValue && dataSource.hasNext {
            return 1
        }
        return 0
    }
    
}

extension PhotosViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == SectionType.Loading.rawValue {
            fetchNextPhotos()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == SectionType.Photo.rawValue {
            if let cellHeight = cellHeights[indexPath] {
                return cellHeight
            } else {
                guard let photo = dataSource?.photos[indexPath.row] else {
                    return 0
                }
                guard let height = photo.height_l, let width = photo.width_l else {
                    return 0
                }
                let cellHeight = CGRectGetWidth(tableView.frame) * CGFloat(height) / CGFloat(width)
                cellHeights[indexPath] = cellHeight
                return cellHeight
            }
        } else if indexPath.section == SectionType.Loading.rawValue,
            let hasNext = dataSource?.hasNext where hasNext {
            return 72
        }
        return 0
    }
    
}
