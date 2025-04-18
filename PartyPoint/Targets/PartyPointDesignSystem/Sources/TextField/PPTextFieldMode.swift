//
//  PPTextFieldMode.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import Foundation

public enum PPTextFieldMode {
    case none
    case disabled(infoText: String?)
    case clearMode
    case secureMode
}
