//
//  PPTextFieldModePresenterProtocol.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import UIKit

protocol PPTextFieldAnimatedModePresenterProtocol {
    func setupTitleLabel(label: UILabel)
    func setupRightView(textField: UITextField)
    func textFieldDidChange(textField: UITextField)
    func textFieldCanBecomeFirstResponder() -> Bool
}

extension PPTextFieldAnimatedModePresenterProtocol {
    func textFieldCanBecomeFirstResponder() -> Bool {
        return true
    }
}

protocol PPTextFieldModePresenterProtocol {
    func setupTitleLabel(label: UILabel)
    func setupRightView(textField: PPTextField)
    func textFieldDidChange(textField: PPTextField)
    func textFieldCanBecomeFirstResponder() -> Bool
}

extension PPTextFieldModePresenterProtocol {
    func setupTitleLabel(label: UILabel) {}
    
    func textFieldDidChange(textField: PPTextField) {}
    
    func textFieldCanBecomeFirstResponder() -> Bool {
        return true
    }
}
