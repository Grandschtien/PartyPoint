//
//  LayoutHelper.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 19.08.2022.
//

import Foundation
import UIKit

public let SCREEN_SCALE: CGFloat = {
    return UIView.screenScaleFactor
}()

public let SCREEN_SCALE_BY_HEIGHT: CGFloat = {
    return UIView.heightScreenScaleFactor
}()

public extension Int {
    /// Scale  on current Screen scale
    /// - Returns: scaled value
    func scale() -> CGFloat {
        CGFloat(self) * SCREEN_SCALE
    }
}

public extension Double {
    /// Scale  on current Screen scale
    /// - Returns: scaled value
    func scale() -> CGFloat {
        CGFloat(self) * SCREEN_SCALE
    }
}

public extension Float {
    /// Scale  on current Screen scale
    /// - Returns: scaled value
    func scale() -> CGFloat {
        CGFloat(self) * SCREEN_SCALE
    }
}

public extension CGFloat {
    /// Scale  on current Screen scale
    /// - Returns: scaled value
    func scale() -> CGFloat {
        self * SCREEN_SCALE
    }
}


