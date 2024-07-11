//
//  StatusBarFrame.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//

import UIKit

public var statusBarFrame: CGRect {
    guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first,
          let statusBarFrame = window.windowScene?.statusBarManager?.statusBarFrame else {
        return CGRect(x: 0, y: 0, width: 0, height: 0)
    }
    return statusBarFrame
}
