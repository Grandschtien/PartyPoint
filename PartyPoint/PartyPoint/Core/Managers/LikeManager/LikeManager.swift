//
//  LikeManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 28.02.2023.
//

import Foundation

@objc protocol LikeManager {
    func likeEvent(withId id: Int) async
    func unlikeEvent(withId id: Int) async
    func addListener(_ subcriber: LikeEventListener)
    func removeListener(_ subscriber: LikeEventListener) 
}
