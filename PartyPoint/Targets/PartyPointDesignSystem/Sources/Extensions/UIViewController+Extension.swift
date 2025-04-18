//
//  UIViewController+Extension.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 14.09.2022.
//

import UIKit
import PartyPointResources

extension UIViewController {
    public func changeStatusBarColor(_ color: UIColor?) {
        UIApplication.shared.statusBarView?.backgroundColor = color
    }
    
    public func setBackgroundOfStatusBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = PartyPointResourcesAsset.mainColor.color
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
    }
}
