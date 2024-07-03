//
//  String+Extension.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 14.01.2023.
//

import Foundation
import SwiftSoup

extension String {
    var capitalizedFirst: String {
        guard let firstLetter = self.first else { return "" }
        return firstLetter.uppercased() + self.dropFirst()
    }
    
    func clearFromHTMLTags() -> String {
        guard let parsedHTML = try? SwiftSoup.parse(self), let text = try? parsedHTML.text() else { return self }
        
        return text
    }
}
