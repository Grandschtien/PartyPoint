//
//  UIViewController+Extension.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 14.09.2022.
//

import UIKit

extension UIViewController {
    var statusBarFrame: CGRect {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first,
              let statusBarFrame = window.windowScene?.statusBarManager?.statusBarFrame else {
            return CGRect(x: 0, y: 0, width: 0, height: 0)
        }
        return statusBarFrame
    }
    
    func changeStatusBarColor(_ color: UIColor?) {
        UIApplication.shared.statusBarView?.backgroundColor = color
    }
}
