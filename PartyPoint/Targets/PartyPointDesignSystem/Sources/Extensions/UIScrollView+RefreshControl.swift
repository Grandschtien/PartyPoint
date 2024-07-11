//
//  UIScrollView+RefreshControl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 26.02.2023.
//

import Foundation
import UIKit

private var topPullToRefreshKey: UInt8 = 0

public extension UIScrollView {
    internal var topPullToRefresh: PPRefreshControlView? {
        get {
            return objc_getAssociatedObject(self, &topPullToRefreshKey) as? PPRefreshControlView
        }
        set {
            objc_setAssociatedObject(self, &topPullToRefreshKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addPullToRefresh(spinnerColor: PPSpinnerView.Color = .main, refreshCompletion: (() -> Void)?) {
        let refreshViewFrame = CGRect(x: 0, y: -PPPullToRefreshConstants.height, width: self.frame.size.width, height: PPPullToRefreshConstants.height)
        let refreshView = PPRefreshControlView(spinnerColor: spinnerColor, frame: refreshViewFrame, refreshCompletion: refreshCompletion)
        topPullToRefresh = refreshView
        addSubview(refreshView)
    }
    
    func startPullToRefresh() {
        let refreshView = topPullToRefresh
        refreshView?.state = .refreshing
    }
    
    func stopPullToRefresh(ever: Bool = false) {
        let refreshView = topPullToRefresh
        if ever {
            refreshView?.state = .finish
        } else {
            refreshView?.state = .stop
        }
    }
    
    func removePullToRefresh() {
        let refreshView = topPullToRefresh
        refreshView?.removeFromSuperview()
    }
}

