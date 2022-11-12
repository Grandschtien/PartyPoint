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
            self.font = Fonts.sfProDisplayBold(size: 36.scale())
            self.textColor = .white
        case .secondary:
            self.font = Fonts.sfProDisplayBold(size: 24.scale())
            self.textColor = .white
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
