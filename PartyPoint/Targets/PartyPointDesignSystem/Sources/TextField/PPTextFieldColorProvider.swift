//
//  PPTextFieldColorProvider.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import UIKit
import PartyPointResources

struct PPTextFieldColorProvider {
    
    func titleColor(textField: PPTextField) -> UIColor {
        if case .error(_) = textField.displayState {
            return PartyPointResourcesAsset.textFieldError.color
        } else {
            return PartyPointResourcesAsset.textFieldError.color
        }
    }
    
    func borderColor(textField: PPTextField) -> UIColor {
        if textField.isFirstResponder {
            return PartyPointResourcesAsset.textFieldSelected.color
        }
        
        switch textField.displayState {
            
        case .default, .success:
            return PartyPointResourcesAsset.strokeColor.color
        case .error(_):
            return PartyPointResourcesAsset.textFieldError.color
        }
    }
}
