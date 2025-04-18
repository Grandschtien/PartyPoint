//
//  UIViewController+Loader.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 04.01.2023.
//

import SnapKit
import UIKit

extension UIViewController {
    public func showLoader() {
        let loader = PPSpinnerView(type: .l, color: .main)
        self.view.addSubview(loader)
        loader.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        loader.startAnimation()
    }
    
    public func hideLoader() {
        let loader = self.view.subviews.first { $0 is PPSpinnerView }
        loader?.removeFromSuperview()
    }
    
    public func showLoaderIfNeeded(isLoading: Bool) {
        if isLoading {
            showLoader()
        } else {
            hideLoader()
        }
    }
}
