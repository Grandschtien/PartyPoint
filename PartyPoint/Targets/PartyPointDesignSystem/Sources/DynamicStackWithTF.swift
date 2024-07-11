//
//  DynamicStackWithTF.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import SnapKit
import UIKit

public final class DynamicStackWithTF: UIStackView {
    private(set) var placeholders: [String]
    public var textFields: [PPTextField] = []
    
    public init(frame: CGRect, placeholders: [String]) {
        self.placeholders = placeholders
        super.init(frame: frame)
        setupUI()
    }
    
    public convenience init(placeholders: [String]) {
        self.init(frame: .zero, placeholders: placeholders)
    }
    
    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupUI() {
        self.alignment = .center
        self.axis = .vertical
        self.spacing = 22
        for placeholder in placeholders {
            let appTF = PPTextField()
            appTF.placeholder = placeholder
            textFields.append(appTF)
            self.addArrangedSubview(appTF)
            appTF.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
    }
}
