//
//  SearchScreenViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.02.2023.
//  
//
import UIKit

final class SearchScreenViewController: UIViewController {
    
    // MARK: Private propeties
    private let presenter: SearchScreenPresenter
    private let contentView = SearchScreenContentView()
    
    // MARK: Init
    init(presenter: SearchScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: Overriden methods
    override func loadView() {
        view = contentView
    }
}

// MARK: Private methods
private extension SearchScreenViewController {
    
}

// MARK: Public methods
extension SearchScreenViewController {
    
}

// MARK: SearchScreenView
extension SearchScreenViewController: SearchScreenView {
    
}
