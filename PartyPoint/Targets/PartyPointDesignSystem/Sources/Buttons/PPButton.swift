//
//  PPButton.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import SnapKit
import UIKit

/// Прямоугольная основная кнопка
open class PPButton: PPButtonBase {

    // MARK: - Enum

    public enum Style {
        /// Цвет текста - белый. Цвет фона - красный.
        case primary
        case ghost(titleColor: UIColor)
    }

    public enum Size {
        /// Размер 32
        case s
        /// Размер 44
        case m
        /// Размер 52
        case l
    }

    // MARK: - Public properties

    /// Параметры отображения кнопки
    public lazy var parameters: Parameters = {
        fatalError("У кнопки не указан parameters")
    }() {
        didSet {
            layer.cornerRadius = parameters.cornerRadius
            titleLabel?.font = parameters.titleFont
            setupTitleColor()
            setupTintColor()
            setupBackgroundColor()
            setupContentEdgeInsets()
            imageView?.contentMode = .scaleAspectFit
        }
    }

    /// Активность индикатора загрузки
    public var isLoading: Bool = false {
        didSet {
            isLoading ? startLoadingAnimation() : stopLoadingAnimation()
        }
    }

    // MARK: - Private properties

    private lazy var spinnerView = PPSpinnerView(type: .m)

    // MARK: - Overriden properties

    public override var isEnabled: Bool {
        didSet {
            setupBackgroundColor()
            setupTitleColor()
            setupTintColor()
        }
    }

    public override var intrinsicContentSize: CGSize {
        var width = titleSize().width
        if image(for: state) != nil {
            if !width.isZero {
                width += parameters.imageRightInset
            }
            width += parameters.imageSize.width
        }
        width += contentEdgeInsets.left + contentEdgeInsets.right
        return .init(width: width,
                     height: parameters.intrinsicContentHeight)
    }

    // MARK: - Init

    public init(style: Style, size: Size) {
        super.init(frame: .zero)

        parameters = Parameters(style: style, size: size)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Overriden methods

    public override func setImage(_ image: UIImage?, for state: UIControl.State) {
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        super.setImage(tintedImage, for: .normal)
    }

    public override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleWidth = titleSize().width

        var origin = CGPoint(x: contentRect.origin.x + contentRect.width / 2 - titleWidth / 2,
                             y: (contentRect.height - parameters.imageSize.height) / 2)

        if image(for: state) == nil {
            return .init(origin: origin, size: .zero)
        }

        origin.x -= (parameters.imageSize.width + parameters.imageRightInset) / 2

        return .init(origin: origin, size: parameters.imageSize)
    }

    public override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageRect = imageRect(forContentRect: contentRect)
        let titleSize = titleSize()

        var origin = CGPoint(x: imageRect.maxX,
                             y: (contentRect.height - titleSize.height) / 2)

        if image(for: state) != nil {
            origin.x += parameters.imageRightInset
        }

        return .init(x: origin.x,
                     y: origin.y,
                     width: titleSize.width,
                     height: titleSize.height)
    }

    // MARK: - Layout

    public override func layoutSubviews() {
        super.layoutSubviews()

        titleLabel?.alpha = isLoading ? 0 : 1
        imageView?.alpha = isLoading ? 0 : 1
    }

    // MARK: - Overriden setup

    override func setupView() {
        super.setupView()

        adjustsImageWhenHighlighted = false
        adjustsImageWhenDisabled = false
    }

    // MARK: - Private methods

    private func startLoadingAnimation() {
        self.addSubview(spinnerView)
        spinnerView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        spinnerView.startAnimation()
        spinnerView.tintColor = parameters.titleColor.enabled
    }

    private func stopLoadingAnimation() {
        spinnerView.stopAnimation()
        spinnerView.removeFromSuperview()
    }

    private func setupBackgroundColor() {
        backgroundColor = isEnabled ? parameters.backgroundColor.enabled : parameters.backgroundColor.disabled
    }

    private func setupTitleColor() {
        let titleColor = isEnabled ? parameters.titleColor.enabled : parameters.titleColor.disabled
        setTitleColor(titleColor, for: .normal)
    }

    private func setupTintColor() {
        tintColor = isEnabled ? parameters.titleColor.enabled : parameters.titleColor.disabled
    }

    private func setupContentEdgeInsets() {
        contentEdgeInsets = .init(top: 0,
                                  left: parameters.contentSideInset,
                                  bottom: 0,
                                  right: parameters.contentSideInset)
    }

    private func titleSize() -> CGSize {
        guard let text = title(for: state), !text.isEmpty else {
            return .zero
        }

        let textAttributes = [NSAttributedString.Key.font: parameters.titleFont]
        let size = CGSize(width: .greatestFiniteMagnitude,
                          height: parameters.intrinsicContentHeight)
        let rect = text.boundingRect(with: size,
                                     options: .usesLineFragmentOrigin,
                                     attributes: textAttributes,
                                     context: nil)
        return .init(width: ceil(rect.width),
                     height: ceil(rect.height))
    }
}

