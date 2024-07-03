//
//  PPToastData.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import UIKit

/// Структура с параметрами для показа Toast
public struct PPToastData {

    // MARK: - Enums

    enum ToastType {
        case toast
        case snackbar
    }

    enum IconType {
        case small
        case custom
    }

    // MARK: - Constants

    public enum Constants {
        public static let defaultShowingDuration = 3.0
    }

    // MARK: Properties

    /// Иконка для отображения
    let icon: Icon

    /// Опциональный заголовок сообщения
    let title: String?

    /// Текст сообщения
    let text: String

    /// Время, через которое убирается сообщение. Если 0, то сообщение не закрывается автоматически. Нужно показать другое  или закрыть через MTSToast.dismissCurrentMessage().
    let showingDuration: TimeInterval

    /// Кнопки
    let action: Action?

    /// Категория сообщения. Если категория сообщения совпадает с категорией уже отображаемого тоста, то новое сообщение не отобразится.
    let category: String?

    // MARK: - Properties

    var type: ToastType {
        action == nil ? .toast : .snackbar
    }

    var iconType: IconType {
        switch icon {
        case .info, .warning, .done, .error:
            return .small
        default:
            return .custom
        }
    }

    // MARK: - Init

    public init(title: String? = nil,
                text: String,
                icon: Icon = .none,
                showingDuration: TimeInterval = Constants.defaultShowingDuration,
                action: Action? = nil,
                category: String? = nil) {
        self.title = title
        self.text = text
        self.icon = icon
        self.showingDuration = showingDuration
        self.action = action
        self.category = category
    }
}


public extension PPToastData {
    struct Action {

        // MARK: - Properties

        // Текст кнопки
        let title: String

        // Замыкание, которое нужно выполнить при нажатии на кнопку
        let closure: () -> Void

        // MARK: - Init

        public init(title: String, closure: @escaping () -> Void) {
            self.title = title
            self.closure = closure
        }
    }
}

extension PPToastData {

    // MARK: - Enum

    /// Перечисление со стандартыми иконками для Toast, также есть custom(UIImage), в нем можно задать кастомную картинку.
    public enum Icon: Equatable {

        // MARK: - Cases

        case none
        case done
        case warning
        case info
        case error
        case countdown
        case custom(UIImage, isRounded: Bool)

        func iconImage() -> UIImage? {
            switch self {
            case .custom(let image, _):
                return image
            case .done:
                return R.image.icDoneBanner()
            case .warning:
                return R.image.icWarningBanner()
            case .info:
                return R.image.icInfoBanner()
            case .error:
                return R.image.icErrorBanner()
            default:
                return nil
            }
        }
    }

    // MARK: - Methods

    func iconView(side: CGFloat) -> UIView? {
        guard icon != .none else {
            return nil
        }

        if icon == .countdown {
            return PPToastCountdownView(seconds: Int(showingDuration))
        }

        let iconView = UIImageView(image: icon.iconImage())
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true

        if case .custom(_, let isRounded) = icon {
            if isRounded {
                iconView.layer.cornerRadius = side / 2
            }
        }

        return iconView
    }
}
