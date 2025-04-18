//
//  SearchViewConfiguration.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 19.03.2023.
//

import Foundation
import PartyPointResources

struct SearchViewConfiguration {
    let title: String
    let subtitle: String
}

extension SearchViewConfiguration {
    static let `default` = SearchViewConfiguration(title:PartyPointResourcesStrings.Localizable.searchDefaultTitle,
                                                   subtitle:PartyPointResourcesStrings.Localizable.searchDefaultSubtitle)
    static let empty = SearchViewConfiguration(title:PartyPointResourcesStrings.Localizable.searchEmptyResultsTitle, subtitle:PartyPointResourcesStrings.Localizable.searchEmptyResultsSubtitle)
}
