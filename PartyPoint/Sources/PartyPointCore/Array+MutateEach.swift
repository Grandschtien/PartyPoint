//
//  Array+MutateEach.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 03.01.2023.
//

import Foundation

extension Array {
    mutating func mutateEach(by transform: (inout Element) throws -> Void) rethrows {
        self = try map { el in
            var el = el
            try transform(&el)
            return el
        }
     }
}
