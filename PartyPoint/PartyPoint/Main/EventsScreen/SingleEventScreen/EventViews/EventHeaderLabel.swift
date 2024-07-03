//
//  EventHeaderLabel.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 19.08.2022.
//

import UIKit

final class EventHeaderLabel: UILabel {
    
    enum LabelType {
        case main
        case secondary
    }
    
    init(frame: CGRect, labelType: LabelType) {
        super.init(frame: frame)
        
        switch labelType {
        case .main:
            self.font = R.font.sfProDisplayBold(size: 28.scale())
            self.textColor = .white
            self.numberOfLines = 0
        case .secondary:
            self.font = R.font.sfProDisplayBold(size: 24.scale())
            self.textColor = .white
        }
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}
