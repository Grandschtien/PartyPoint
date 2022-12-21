//
//  PPTextFieldMode.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import Foundation

public enum PPTextFieldMode {
    /// Режим по умолчанию
    case none
    /// Неактивное поле. Можно только скопировать текст или показать инфо.
    case disabled(infoText: String?)
    /// Справа появляется кнопка *Удалить текст*
    case clearMode
    /// Справа появляется кнопка *Показать/скрыть текст*
    case secureMode
}
