//
//  LikeEventListener.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 28.02.2023.
//

import Foundation

@objc protocol LikeEventListener {
    @objc optional func likeManager(_ likeManager: LikeManager, willLikeEventWithId id: Int)
    @objc optional func likeManager(_ likeManager: LikeManager, didLikeEventWithId id: Int)
    @objc optional func likeManager(_ likeManager: LikeManager, willRemoveLikeEventWithId id: Int)
    @objc optional func likeManager(_ likeManager: LikeManager, didREmoveLikeEventWithId id: Int)
}
