//
//  ManageProfileConfiguration.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//

import Foundation

struct ManageProfileConfiguration {
    let title: String
    let subtitle: String
}

extension ManageProfileConfiguration {
    static let chnagePassword = ManageProfileConfiguration(title: R.string.localizable.profile_password(),
                                                           subtitle: R.string.localizable.profile_manage())
    static let changeCity = ManageProfileConfiguration(title: R.string.localizable.profile_city(),
                                                       subtitle: R.string.localizable.profile_manage())
    static let aboutApp = ManageProfileConfiguration(title: R.string.localizable.profile_about_app(),
                                                     subtitle: R.string.localizable.prfile_read_about_app())
}
