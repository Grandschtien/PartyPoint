//
//  String+Extension.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 14.01.2023.
//

import Foundation

extension String {
    var capitalizedFirst: String {
        guard let firstLetter = self.first else { return "" }
        return firstLetter.uppercased() + self.dropFirst()
    }
}
