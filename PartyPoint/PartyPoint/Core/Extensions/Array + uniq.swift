//
//  Array + uniq.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 09.05.2023.
//

import Foundation

extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}
