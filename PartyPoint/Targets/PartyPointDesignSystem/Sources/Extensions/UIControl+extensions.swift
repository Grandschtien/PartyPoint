//
//  UIControl+extensions.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import UIKit

extension UIControl {

    enum AnimationConstants {
        static let tapAnimationDuration = 0.15
        static let tapScale: CGFloat = 0.95
    }

    public func setupControlAnimation() {

        addTarget(self,
                  action: #selector(downAnimation),
                  for: [.touchDown])
        addTarget(self,
                  action: #selector(upAnimation),
                  for: [.touchDragExit, .touchUpInside, .touchUpOutside, .touchCancel])
    }

    @objc func downAnimation() {
        UIView.animate(withDuration: AnimationConstants.tapAnimationDuration,
                       delay: 0.0,
                       options: [.allowUserInteraction, .curveEaseInOut],
                       animations: {
                        self.layer.transform = CATransform3DMakeScale(AnimationConstants.tapScale, AnimationConstants.tapScale, 1)
        }, completion: { _ in
            self.upAnimation()
        })
    }

    @objc func upAnimation() {
        if !isTracking && layer.animation(forKey: "transform") == nil {
            UIView.animate(withDuration: AnimationConstants.tapAnimationDuration,
                           delay: 0.0,
                           options: [.allowUserInteraction, .curveEaseInOut],
                           animations: {
                            self.layer.transform = CATransform3DIdentity
                           }, completion: { _ in
                            self.upAnimationCompleted()
                           })
        }
    }

    @objc func upAnimationCompleted() {}
}
