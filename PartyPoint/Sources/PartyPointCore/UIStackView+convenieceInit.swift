//
//  UIStackView+convenieceInit.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 14.07.2022.
//

import UIKit

// Extension #7 - Make UIStackView creation a lot easier.
extension UIStackView {

    /// `UIStackView` convenience initializer for creating a stack view with arranged subviews, an
    /// axis and spacing.
    ///
    /// - Parameters:
    ///   - alignment: The alignment of the arranged subviews perpendicular to the stack view’s
    ///                axis.
    ///   - arrangedSubviews: The subviews to arrange in the `UIStackView`.
    ///   - axis: The axis that the subviews should be arranged around.
    ///   - distribution: The distribution of the arranged views along the stack view’s axis.
    ///   - spacing: The spacing to place between each arranged subview. Defaults to 0.
    ///
    convenience init(alignment: UIStackView.Alignment = .fill,
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
