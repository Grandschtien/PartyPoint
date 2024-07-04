//
//  SearchViewConfiguration.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 19.03.2023.
//

import Foundation

struct SearchViewConfiguration {
    let title: String
    let subtitle: String
}

extension SearchViewConfiguration {
    static let `default` = SearchViewConfiguration(title: PartyPointStrings.Localizable.searchDefaultTitle,
                                                   subtitle: PartyPointStrings.Localizable.searchDefaultSubtitle)
    static let empty = SearchViewConfiguration(title: PartyPointStrings.Localizable.searchEmptyResultsTitle, subtitle: PartyPointStrings.Localizable.searchEmptyResultsSubtitle)
}
