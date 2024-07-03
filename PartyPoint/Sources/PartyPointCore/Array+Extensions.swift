//
//  Array+Extensions.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 03.03.2023.
//

import Foundation

extension Array where Element: AnyObject {
    mutating func appendIfNot(_ element: Element) {
        if !self.contains(where: { $0 === element }) {
            self.append(element)
        }
    }
}
