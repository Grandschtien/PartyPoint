//
//  UIApplication+UniversalLink.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.05.2023.
//

import UIKit

extension UIApplication {
    static func open(viewController: UIViewController) {
        let navigationController = (Self.mainKeyWindow?.rootViewController as? UITabBarController)?.viewControllers?.first as? UINavigationController
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
