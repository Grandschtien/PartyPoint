//
//  PPSearchController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 18.03.2023.
//

import SnapKit
import UIKit
import PartyPointResources

public final class PPSearchController: UISearchController {
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupSearchBar()
    }
    
    override public init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        setupSearchBar()
    }
    
    required public init?(coder: NSCoder) {
        return nil
    }
}

private extension PPSearchController {
    func setupSearchBar() {
        self.searchBar.placeholder = PartyPointResourcesStrings.Localizable.searchBarTitle
        self.searchBar.returnKeyType = .search
        self.searchBar.tintColor = PartyPointResourcesAsset.miniColor.color
    }
}
