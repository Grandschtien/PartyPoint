//
//  ManageProfileConfiguration.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//

import Foundation
import PartyPointResources

struct ManageProfileConfiguration {
    let title: String
    let subtitle: String
}

extension ManageProfileConfiguration {
    static let chnagePassword = ManageProfileConfiguration(title: PartyPointResourcesStrings.Localizable.profilePassword,
                                                           subtitle:PartyPointResourcesStrings.Localizable.profileManage)
    static let changeCity = ManageProfileConfiguration(title:PartyPointResourcesStrings.Localizable.profileCity,
                                                       subtitle:PartyPointResourcesStrings.Localizable.profileManage)
    static let aboutApp = ManageProfileConfiguration(title:PartyPointResourcesStrings.Localizable.profileAboutApp,
                                                     subtitle:PartyPointResourcesStrings.Localizable.prfileReadAboutApp)
}
