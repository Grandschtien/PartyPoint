//
//  Section.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.07.2022.
//

import Foundation

struct Section<T: Hashable> {
    var id = UUID()
    let header: String?
    var items: [T]
}

extension Section: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Section, rhs: Section) -> Bool {
      lhs.id == rhs.id
    }
}
