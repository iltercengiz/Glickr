//
//  SearchViewController.swift
//  Glickr
//
//  Created by Ilter Cengiz on 06/06/16.
//  Copyright © 2016 Ilter Cengiz. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private weak var photosContainerView: UIView!
    private var photosViewController: PhotosViewController!
    private var searchDataSource = SearchDataSource()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == String(PhotosViewController) {
            photosViewController = segue.destinationViewController as! PhotosViewController
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchDataSource.query = searchText
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        photosContainerView.hidden = false
        photosViewController.dataSource = searchDataSource
    }
    
}
