//
//  UIStackView+convenieceInit.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 14.07.2022.
//

import UIKit

extension UIStackView {
    convenience public init(alignment: UIStackView.Alignment = .fill,
                            arrangedSubviews: [UIView],
                            axis: NSLayoutConstraint.Axis,
                            distribution: UIStackView.Distribution = .fill,
                            spacing: CGFloat = 0) {
        arrangedSubviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        self.init(arrangedSubviews: arrangedSubviews)
        self.alignment = alignment
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
    }
}
