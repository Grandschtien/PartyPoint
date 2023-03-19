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
    static let `default` = SearchViewConfiguration(title: Localizable.search_default_title(),
                                                   subtitle: Localizable.search_default_subtitle())
    static let empty = SearchViewConfiguration(title: Localizable.search_empty_results_title(), subtitle: Localizable.search_empty_results_subtitle())
}
