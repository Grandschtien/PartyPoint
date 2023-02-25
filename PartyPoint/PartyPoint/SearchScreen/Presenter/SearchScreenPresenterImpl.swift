//
//  SearchScreenPresenterImpl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.02.2023.
//  
//

final class SearchScreenPresenterImpl {
    private weak var view: SearchScreenView?
    
}

// MARK: Private methods
private extension SearchScreenPresenterImpl {

}

// MARK: Public methods
extension SearchScreenPresenterImpl {
    func setView(_ view: SearchScreenView) {
        self.view = view
    }
}

// MARK: SearchScreenPresenter
extension SearchScreenPresenterImpl: SearchScreenPresenter {
    
}

