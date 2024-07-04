//
//  PPButton+Parameters.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import UIKit

extension PPButton {

    /// Параметры отображения прямоугольной *Main* кнопки
    public struct Parameters {

        // MARK: - Color struct

        public struct Color {
            /// Цвет в активном состоянии
            public var enabled: UIColor

            /// Цвет в неактивном состоянии
            public var disabled: UIColor
        }

        // MARK: - Parameters

        public var backgroundColor: Color
        public var titleColor: Color
        public var cornerRadius: CGFloat
        public var titleFont: UIFont
        public var intrinsicContentHeight: CGFloat
        public var imageSize: CGSize
        public var imageRightInset: CGFloat
        public var contentSideInset: CGFloat

        // MARK: - Init

        init(style: Style, size: Size) {
            switch style {
            case .primary:
                backgroundColor = Color(enabled: PartyPointAsset.buttonColor.color,
                                        disabled: PartyPointAsset.buttonColor.color.withAlphaComponent(0.5))
                titleColor = Color(enabled: PartyPointAsset.miniColor.color,
                                   disabled: PartyPointAsset.miniColor.color.withAlphaComponent(0.5))
            case let .ghost(titleColor):
                backgroundColor = Color(enabled: PartyPointAsset.miniColor.color.withAlphaComponent(0.1),
                                        disabled: PartyPointAsset.miniColor.color.withAlphaComponent(0.1))
                self.titleColor = Color(enabled: titleColor, disabled: titleColor.withAlphaComponent(0.5))
            }

            switch size {
            case .s:
                cornerRadius = 6
                titleFont = PartyPointFontFamily.SFProDisplay.bold.font(size: 14) ?? .systemFont(ofSize: 14)
                intrinsicContentHeight = 32
                imageSize = CGSize(width: 16, height: 16)
                imageRightInset = 4
                contentSideInset = 12
            case .m:
                cornerRadius = 8
                titleFont = PartyPointFontFamily.SFProDisplay.bold.font(size: 17) ?? .systemFont(ofSize: 17)
                intrinsicContentHeight = 44
                imageSize = CGSize(width: 16, height: 16)
                imageRightInset = 6
                contentSideInset = 12
            case .l:
                cornerRadius = 8
                titleFont = PartyPointFontFamily.SFProDisplay.semibold.font(size: 20) ?? .systemFont(ofSize: 20)
                intrinsicContentHeight = 52
                imageSize = CGSize(width: 24, height: 24)
                imageRightInset = 8
                contentSideInset = 20
            }
        }
    }
}
