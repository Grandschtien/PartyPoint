//
//  PPToast.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import SnapKit
import UIKit

public class PPToast {

    // MARK: - Consts

    private enum Constants {
        static let animationDuration: TimeInterval = 0.25
        static let bottomGap: CGFloat = 4
        static let sideGap: CGFloat = 12
        static let scaleFactor: CGFloat = 0.95
    }

    // MARK: - Public properties

    /// Отступ от нижнего края экрана до *MTSToastView*.
    public static var bottomOffset: CGFloat = 0 {
        didSet {
            PPToast.shared.showToastViewAnimation()
        }
    }

    /// Отображаемый тост
    public static var currentToastView: PPToastView? {
        return shared.currentToastView
    }

    // MARK: - Internal properties

    static var shared: PPToast = {
        return PPToast()
    }()

    var containerView: UIView? {
        return UIApplication.mainKeyWindow
    }

    // MARK: - Private roperties

    private var dismissToastWorkItem: DispatchWorkItem?

    private weak var currentToastView: PPToastView?

    // MARK: - Public methods

    /// Показывает Toast
    ///
    /// - Parameter data: Структуры параметров для отображения Toast
    public static func show(_ data: PPToastData) {
        shared.show(data)
    }

    /// Скрывает последнее показанное  сообщение Toast
    public static func dismissCurrent() {
        shared.dismissCurrentToastView()
    }

    // MARK: - Private methods

    private func show(_ data: PPToastData) {
        waitToDismissToastView(duration: data.showingDuration)

        guard let containerView = containerView else {
            return
        }

        if !shouldShowNewToast(category: data.category) {
            currentToastView?.updateView(with: data)
            return
        }

        dismissCurrentToastView()

        addToastView(in: containerView,
                     data: data)

        showToastViewAnimation()
    }

    private func waitToDismissToastView(duration: TimeInterval) {
        dismissToastWorkItem?.cancel()

        guard !duration.isZero else {
            return
        }

        dismissToastWorkItem = DispatchWorkItem(block: { [weak self] in
            self?.dismissCurrentToastView()
        })

        if let dismissToastWorkItem = dismissToastWorkItem {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration,
                                          execute: dismissToastWorkItem)
        }
    }

    private func addToastView(in containerView: UIView, data: PPToastData) {
        let toastView = PPToastView(data: data)

        let bottomMargin = containerView.layoutMargins.bottom
        let bottom = bottomMargin + Constants.bottomGap
        
        containerView.addSubview(toastView)
        
        toastView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-bottom)
        }

        if data.type == .snackbar {
            toastView.leftAnchor.constraint(equalTo: containerView.leftAnchor,
                                            constant: Constants.sideGap).isActive = true
        } else {
            toastView.leftAnchor.constraint(greaterThanOrEqualTo: containerView.leftAnchor,
                                            constant: Constants.sideGap).isActive = true
        }

        toastView.layoutIfNeeded()

        setupDismissedTransform(toastView: toastView)

        currentToastView = toastView
    }

    private func showToastViewAnimation() {
        guard let toastView = currentToastView else {
            return
        }

        UIView.animate(withDuration: Constants.animationDuration,
                       delay: 0,
                       options: .curveEaseInOut) {
            self.setupPresentedTransform(toastView: toastView)
        }
    }

    private func dismissCurrentToastView() {
        guard let toastView = currentToastView else {
            return
        }

        UIView.animate(withDuration: Constants.animationDuration,
                       delay: 0,
                       options: .curveEaseOut) {
            self.setupDismissedTransform(toastView: toastView)
        } completion: { _ in
            toastView.removeFromSuperview()
        }
    }

    private func setupDismissedTransform(toastView: PPToastView) {
        let bottomMargin = containerView?.layoutMargins.bottom ?? 0
        let toastHeight = toastView.bounds.height

        let yTranslation = bottomMargin + Constants.bottomGap + toastHeight

        toastView.transform = .identity.scaledBy(x: Constants.scaleFactor,
                                                 y: Constants.scaleFactor).translatedBy(x: 0, y: yTranslation)
    }

    private func setupPresentedTransform(toastView: PPToastView) {
        toastView.transform = .identity.translatedBy(x: 0,
                                                     y: -PPToast.bottomOffset)
    }

    private func shouldShowNewToast(category: String?) -> Bool {
        guard let currentMessageCategory = currentToastView?.category,
              let newMessageCategory = category else {
            return true
        }

        return currentMessageCategory != newMessageCategory
    }
}

