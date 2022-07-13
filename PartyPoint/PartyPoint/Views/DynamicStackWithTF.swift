//
//  DynamicStackWithTF.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import Foundation
import UIKit

final class DynamicStackWithTF: UIStackView {
    
    private(set) var placeholders: [String]
    
    private(set) var textFields: [AppTextField]?
    
    init(frame: CGRect, placeholders: [String]) {
        self.placeholders = placeholders
        super.init(frame: frame)
        setupUI()
    }
    
    convenience init(placeholders: [String]) {
        self.init(frame: .zero, placeholders: placeholders)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        self.alignment = .center
        self.axis = .vertical
        self.spacing = 22
        for placeholder in placeholders {
            let appTF = AppTextField(frame: frame, placeholder: placeholder)
            appTF.translatesAutoresizingMaskIntoConstraints = false
            textFields?.append(appTF)
            self.addArrangedSubview(appTF)
            appTF.heightAnchor.constraint(equalToConstant: 50).isActive = true
            appTF.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            appTF.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
    }
}
