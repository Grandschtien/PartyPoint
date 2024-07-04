//
//  UIViewController+Extension.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 14.09.2022.
//

import UIKit

extension UIViewController {
    func changeStatusBarColor(_ color: UIColor?) {
        UIApplication.shared.statusBarView?.backgroundColor = color
    }
    
    func setBackgroundOfStatusBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = PartyPointAsset.mainColor.color
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
    }
}
