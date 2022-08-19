//
//  CollectionHeader.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.07.2022.
//

import UIKit

final class EventsTypeHeaderHeader: UICollectionReusableView {
    private lazy var header: UILabel = {
        let label = UILabel()
        label.textColor = .miniColor
        label.font = UIFont(name: UIFont.SFProDisplayBold, size: 24)
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont(name: UIFont.SFProDisplayBold, size: 24)
        btn.setTitle(LabelTexts.moreButton.rawValue, for: .normal)
        btn.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        return btn
    }()
    
    var btnAction: (() -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(withHeader header: String) {
        self.header.text = header
    }
    private func setupLabel() {
        self.addConstrained(subview: moreButton, top: 0, left: nil, bottom: 0, right: -10)
        self.moreButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.addConstrained(subview: header, top: 0, left: 10, bottom: 0, right: nil)
        self.header.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    @objc
    private func moreAction() {
        btnAction?()
    }
}
