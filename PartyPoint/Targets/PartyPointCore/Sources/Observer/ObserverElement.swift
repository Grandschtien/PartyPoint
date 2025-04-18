//
//  ObserverElement.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 03.03.2023.
//

import Foundation

struct ObserverElement<T: AnyObject> {
    weak var value: T?
}

extension ObserverElement {
    func matches(_ other: T) -> Bool {
        return value === (other as AnyObject)
    }
    
    func matches(_ other: ObserverElement<T>) -> Bool {
        return value === other.value
    }
}
