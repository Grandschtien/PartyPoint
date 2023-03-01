//
//  LikeEventListener.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 28.02.2023.
//

import Foundation

@objc protocol LikeEventListener {
    @objc optional func likeManager(_ likeManager: LikeEventListener, willLikeEventWithId id: Int)
    @objc optional func likeManager(_ likeManager: LikeEventListener, didLikeEventWithId id: Int)
    @objc optional func likeManager(_ likeManager: LikeEventListener, willRemoveLikeEventWithId id: Int)
    @objc optional func likeManager(_ likeManager: LikeEventListener, didREmoveLikeEventWithId id: Int)
}
