//
//  File.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import Foundation

class PPTextFieldRightViewButton: PPButtonBase {
    
    // MARK: - Constants
    enum Constants {
        static let rightInset: CGFloat = 12
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: Constants.rightInset)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
}
