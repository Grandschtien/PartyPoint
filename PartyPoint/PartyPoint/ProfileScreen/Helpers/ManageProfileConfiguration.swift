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
    static let chnagePassword = ManageProfileConfiguration(title: Localizable.profile_password(),
                                                           subtitle: Localizable.profile_manage())
    static let changeCity = ManageProfileConfiguration(title: Localizable.profile_city(),
                                                       subtitle: Localizable.profile_manage())
    static let aboutApp = ManageProfileConfiguration(title: Localizable.profile_about_app(),
                                                     subtitle: Localizable.prfile_read_about_app())
}
