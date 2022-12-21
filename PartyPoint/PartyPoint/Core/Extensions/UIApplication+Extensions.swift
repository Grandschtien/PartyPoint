//
//  UIApplication+StatusBar.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 14.09.2022.
//

import UIKit

extension UIApplication {
    static var safeShared: UIApplication? {
        guard responds(to: Selector(("sharedApplication"))) else {
            return nil
        }

        return perform(Selector(("sharedApplication")))?.takeUnretainedValue() as? UIApplication
    }

    static var mainKeyWindow: UIWindow? {
        get {
            if #available(iOS 13, *) {
                return safeShared?.connectedScenes
                    .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                    .first { $0.isKeyWindow }
            } else {
                return safeShared?.keyWindow
            }
        }
    }

    static var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            let window = safeShared?.windows.filter { $0.isKeyWindow }.first
            return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        }
        return safeShared?.statusBarFrame.height ?? 0
    }
    
    var statusBarView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 38482
            let keyWindow = UIApplication.shared.windows.first
            if let statusBar = keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                guard let statusBarFrame = keyWindow?.windowScene?.statusBarManager?.statusBarFrame else {
                    return nil
                }
                let statusBarView = UIView(frame: statusBarFrame)
                statusBarView.tag = tag
                keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
        } else {
            return value(forKey: "statusBar") as? UIView
        }
    }
}
