//
//  PPSearchController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 18.03.2023.
//

import SnapKit

final class PPSearchController: UISearchController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupSearchBar()
    }
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        setupSearchBar()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

private extension PPSearchController {
    func setupSearchBar() {
        self.searchBar.placeholder = R.string.localizable.search_bar_title()
        self.searchBar.returnKeyType = .search
        self.searchBar.tintColor = R.color.miniColor()
    }
}
