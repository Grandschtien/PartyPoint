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
    static let `default` = SearchViewConfiguration(title: R.string.localizable.search_default_title(),
                                                   subtitle: R.string.localizable.search_default_subtitle())
    static let empty = SearchViewConfiguration(title: R.string.localizable.search_empty_results_title(), subtitle: R.string.localizable.search_empty_results_subtitle())
}
