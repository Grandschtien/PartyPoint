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
            return Colors.text_field_error() ?? .red
        } else {
            return Colors.text_field_error() ?? .gray
        }
    }
    
    func borderColor(textField: PPTextField) -> UIColor {
        if textField.isFirstResponder {
            return Colors.text_field_selected() ?? .blue
        }
        
        switch textField.displayState {
            
        case .default, .success:
            return Colors.stroke_color() ?? .gray
        case .error(_):
            return Colors.text_field_error() ?? .red
        }
    }
}
