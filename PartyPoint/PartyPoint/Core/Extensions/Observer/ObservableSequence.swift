//
//  ObservableSequence.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 03.03.2023.
//

import Foundation

class ObservableSequence<T: AnyObject> {
    private lazy var subscribers = [ObserverElement<T>]()
    
    func addListener(_ subcriber: T) {
        subscribers = subscribers.filter { $0.value != nil }
        
        if !subscribers.contains(where: {$0.matches(subcriber) }) {
            subscribers.append(ObserverElement(value: subcriber))
        }
    }
    
    func removeListener(_ subscriber: T) {
        subscribers = subscribers.filter { $0.value != nil && !$0.matches(subscriber)}
    }
}

extension ObservableSequence: Sequence {
    func makeIterator() -> AnyIterator<T> {
        let nonNilSubscribers = subscribers.compactMap({ $0.value })
        return AnyIterator(nonNilSubscribers.makeIterator())
    }
}

extension ObservableSequence: Collection {
    typealias Index = Int
    
    var startIndex: Index {
        return subscribers.startIndex
    }
    
    var endIndex: Index {
        return subscribers.endIndex
    }
    
    subscript (position: Index) -> T {
        return subscribers[position].value!
    }
    
    func index(after i: Index) -> Index {
        return subscribers.index(after: i)
    }
}


