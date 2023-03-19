//
//  SearchScreenPresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.02.2023.
//  
//

import Foundation

protocol SearchScreenPresenter: AnyObject {
    func searchStarted(searchString str: String?)
    func loadNextPageWithWithCurrentLexeme(page: Int)
    func openEvent(withIndex index: Int)
    func willPresentSearch()
    func willDismissSearch()
}

