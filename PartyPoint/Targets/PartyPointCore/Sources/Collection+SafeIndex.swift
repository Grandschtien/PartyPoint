//
//  Array+safe.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 08.02.2023.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
