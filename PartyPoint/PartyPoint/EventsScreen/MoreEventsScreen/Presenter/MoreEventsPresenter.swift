//
//  MoreEventsPresenter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//  
//

import Foundation

protocol MoreEventsPresenter: AnyObject {
    func onViewDidLoad()
    func loadNextPage(page: Int)
    func tappedOnEvent(index: Int)
}

