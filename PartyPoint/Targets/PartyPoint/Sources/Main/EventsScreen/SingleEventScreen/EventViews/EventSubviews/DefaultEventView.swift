//
//  DefaultEventView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.01.2023.
//

import SnapKit
import UIKit

class DefaultEventView: UIView {
    internal let titleLabel = EventHeaderLabel(frame: .zero, labelType: .secondary)
    
    var titleText: String {
        assertionFailure("TitleText must be overriden")
        return ""
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setupUI() {
        self.addSubview(titleLabel)
        titleLabel.text = titleText
        setupConstraints()
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
    }
}
