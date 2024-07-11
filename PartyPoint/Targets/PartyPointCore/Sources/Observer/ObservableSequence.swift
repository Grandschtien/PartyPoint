//
//  ObservableSequence.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 03.03.2023.
//

import Foundation

public class ObservableSequence<T: AnyObject> {
    private lazy var subscribers = [ObserverElement<T>]()
    
    public init() {}
    
    public func addListener(_ subcriber: T) {
        subscribers = subscribers.filter { $0.value != nil }
        
        if !subscribers.contains(where: { $0.matches(subcriber) }) {
            subscribers.append(ObserverElement(value: subcriber))
        }
    }
    
    public func removeListener(_ subscriber: T) {
        subscribers = subscribers.filter { $0.value != nil && !$0.matches(subscriber) }
    }
}

extension ObservableSequence: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        let nonNilSubscribers = subscribers.compactMap({ $0.value })
        return AnyIterator(nonNilSubscribers.makeIterator())
    }
}

extension ObservableSequence: Collection {
    public typealias Index = Int
    
    public var startIndex: Index {
        return subscribers.startIndex
    }
    
    public var endIndex: Index {
        return subscribers.endIndex
    }
    
    public subscript (position: Index) -> T {
        return subscribers[position].value!
    }
    
    public func index(after i: Index) -> Index {
        return subscribers.index(after: i)
    }
}


