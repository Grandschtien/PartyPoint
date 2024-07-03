//
//  PPTextFieldColorProvider.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import UIKit

struct PPTextFieldColorProvider {
    
    func titleColor(textField: PPTextField) -> UIColor {
        if case .error(_) = textField.displayState {
            return R.color.text_field_error() ?? .red
        } else {
            return R.color.text_field_error() ?? .gray
        }
    }
    
    func borderColor(textField: PPTextField) -> UIColor {
        if textField.isFirstResponder {
            return R.color.text_field_selected() ?? .blue
        }
        
        switch textField.displayState {
            
        case .default, .success:
            return R.color.stroke_color() ?? .gray
        case .error(_):
            return R.color.text_field_error() ?? .red
        }
    }
}
