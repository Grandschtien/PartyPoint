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
    static let chnagePassword = ManageProfileConfiguration(title:  PartyPointStrings.Localizable.profilePassword,
                                                           subtitle: PartyPointStrings.Localizable.profileManage)
    static let changeCity = ManageProfileConfiguration(title: PartyPointStrings.Localizable.profileCity,
                                                       subtitle: PartyPointStrings.Localizable.profileManage)
    static let aboutApp = ManageProfileConfiguration(title: PartyPointStrings.Localizable.profileAboutApp,
                                                     subtitle: PartyPointStrings.Localizable.prfileReadAboutApp)
}
