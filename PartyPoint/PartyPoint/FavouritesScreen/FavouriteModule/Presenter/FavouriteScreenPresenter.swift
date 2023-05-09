//
//  FavouriteScreenPresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.04.2023.
//  
//

import Foundation

protocol FavouriteScreenPresenter: AnyObject {
    func onViewDidLoad()
    func getUserProfile()
    func didTapOnEvent(withIndex index: Int)
    func eventDisliked(eventInfo: EventInfo)
    func loadNextPage(page: Int)
}

