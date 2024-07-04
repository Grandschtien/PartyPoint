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
            return PartyPointAsset.textFieldError.color
        } else {
            return PartyPointAsset.textFieldError.color
        }
    }
    
    func borderColor(textField: PPTextField) -> UIColor {
        if textField.isFirstResponder {
            return PartyPointAsset.textFieldSelected.color
        }
        
        switch textField.displayState {
            
        case .default, .success:
            return PartyPointAsset.strokeColor.color
        case .error(_):
            return PartyPointAsset.textFieldError.color
        }
    }
}
