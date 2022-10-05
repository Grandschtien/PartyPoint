//
//  AppTextField.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import Foundation
import UIKit

final class AppTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 5)
    
    init(frame: CGRect,
         placeholder: String) {
        super.init(frame: frame)
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: Colors.mainColor()?.withAlphaComponent(0.5) ?? .blue.withAlphaComponent(0.5),
                .font: Fonts.sfProDisplayBold(size: 16) ?? UIFont.systemFont(ofSize: 14),
            ]
        )
        self.textColor = Colors.mainColor()
        self.font = Fonts.sfProDisplayBold(size: 14)
        switch placeholder {
        case Localizable.password_title_registration():
            self.isSecureTextEntry = true
        case Localizable.check_password_title_registration():
            self.isSecureTextEntry = true
        default:
            break
        }
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.borderStyle = .none
        self.backgroundColor = Colors.miniColor()
        self.layer.cornerRadius = 8
    }
    

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
