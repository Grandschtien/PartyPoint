//
//  CollectionHeader.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.07.2022.
//

import UIKit

final class CollectionHeader: UICollectionReusableView {
    private lazy var header: UILabel = {
        let label = UILabel()
        label.textColor = .miniColor
        label.font = UIFont(name: UIFont.SFProDisplayBold, size: 24)
        return label
    }()
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
        self.addConstrained(subview: header, top: 0, left: 20, bottom: 0, right: 0)
    }
}
