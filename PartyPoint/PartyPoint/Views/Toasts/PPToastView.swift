//
//  PPToastView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import SnapKit

final public class PPToastView: UIView {

    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = 12
        static let separatorTopInset: CGFloat = 8
        static let separatorWidth: CGFloat = 0.5
        static let titleSideOffset: CGFloat = 12
        static let titleTopOffsetToast: CGFloat = 8
        static let titleTopOffsetSnackbar: CGFloat = 10
    }

    private func iconInsets(icon: PPToastData.Icon) -> UIEdgeInsets {
        switch icon {
        case .custom(_, _):
            return .init(top: 8, left: 12, bottom: -8, right: -8)
        case .countdown:
            return .init(top: 12, left: 12, bottom: -12, right: -8)
        default:
            return .init(top: 6, left: 10, bottom: -6, right: -6)
        }
    }

    private func iconSide(icon: PPToastData.Icon) -> CGFloat {
        switch icon {
        case .custom(_, _):
            return 44
        case .countdown:
            return 20
        default:
            return 24
        }
    }

    // MARK: - Public properties

    public let category: String?

    // MARK: - Init

    init(data: PPToastData) {
        category = data.category

        super.init(frame: .zero)

        backgroundColor = Colors.mainColor()
        layer.cornerRadius = Constants.cornerRadius

        setupView(data: data)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal methods

    func updateView(with data: PPToastData) {
        for subview in subviews {
            subview.removeFromSuperview()
        }

        setupView(data: data)
    }

    // MARK: - Private methods

    private func setupView(data: PPToastData) {
        // Добавляем базовый горизонтальный стек
        let stackView = UIStackView()
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        // Добавляем иконку
        if let iconContainer = iconContainer(data: data) {
            stackView.addArrangedSubview(iconContainer)
        } else {
            stackView.addArrangedSubview(whitespace(width: Constants.titleSideOffset))
        }

        // Добавляем текст с заголовку
        stackView.addArrangedSubview(textContainer(data: data))
        stackView.addArrangedSubview(whitespace(width: Constants.titleSideOffset))
    }

    private func whitespace(width: CGFloat) -> UIView {
        let whitespace = UIView()
        whitespace.widthAnchor.constraint(equalToConstant: width).isActive = true
        return whitespace
    }

    private func iconContainer(data: PPToastData) -> UIView? {
        let iconSide = iconSide(icon: data.icon)

        guard let iconView = data.iconView(side: iconSide) else {
            return nil
        }

        let insets = iconInsets(icon: data.icon)

        // Иконки в тостах выравниваются по верхнему краю
        if data.type == .toast && data.iconType == .small {
            self.addSubview(iconView)
            iconView.snp.makeConstraints {
                $0.left.equalToSuperview().offset(insets.left)
                $0.right.equalToSuperview().inset(insets.right)
                $0.top.equalToSuperview().offset(insets.top)
                $0.bottom.lessThanOrEqualToSuperview().inset(insets.bottom)
                $0.size.equalTo(iconSide)
            }
            return iconView
        } else {
            self.addSubview(iconView)
            iconView.snp.makeConstraints {
                $0.left.equalToSuperview().offset(insets.left)
                $0.right.equalToSuperview().inset(insets.right)
                $0.top.equalToSuperview().offset(insets.top)
                $0.top.greaterThanOrEqualToSuperview().offset(insets.top)
                $0.size.equalTo(iconSide)
            }
            return iconView
        }
    }

    private func textContainer(data: PPToastData) -> UIView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading

        if let title = data.title, !title.isEmpty {
            let titleLabel = UILabel()
            let fontSize: CGFloat = data.type == .toast ? 14 : 17
            titleLabel.font = Fonts.sfProDisplayBold(size: fontSize)
            titleLabel.textColor = Colors.mainColor()
            titleLabel.numberOfLines = 0
            titleLabel.text = title

            stack.addArrangedSubview(titleLabel)
        }

        let messageLabel = UILabel()
        let fontSize: CGFloat = data.type == .toast ? 14 : 17
        messageLabel.font = Fonts.sfProDisplayRegular(size: fontSize)
        messageLabel.textColor = Colors.mainColor()
        messageLabel.numberOfLines = 0
        messageLabel.text = data.text

        stack.addArrangedSubview(messageLabel)

        let topOffset: CGFloat = data.type == .toast ? Constants.titleTopOffsetToast : Constants.titleTopOffsetSnackbar
        addSubview(stack)
        stack.snp.makeConstraints {
            $0.left.right.centerY.equalToSuperview()
            $0.top.equalToSuperview().offset(topOffset)
        }
        return stack
    }

    private func buttonSeparator() -> UIView {
        let containerView = UIView()

        let separator = UIView()
        separator.backgroundColor = Colors.mainColor()
        containerView.addSubview(separator)
        separator.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.separatorTopInset)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Constants.separatorTopInset)
            $0.width.equalTo(Constants.separatorWidth)
        }
        
        return containerView
    }
}

