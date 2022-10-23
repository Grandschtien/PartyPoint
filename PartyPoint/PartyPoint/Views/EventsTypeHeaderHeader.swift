//
//  CollectionHeader.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.07.2022.
//

import UIKit

private let HEADER_FONT_SIZE: CGFloat = 24 * SCREEN_SCALE_BY_HEIGHT
private let MORE_BUTTON_RIGHT_INSET: CGFloat = 10
private let MORE_BUTTON_WIDTH: CGFloat = 50.scale()
private let HEADER_LEFT_OFFSET: CGFloat = 10

final class EventsTypeHeaderHeader: UICollectionReusableView {
    private lazy var header: UILabel = {
        let label = UILabel()
        label.textColor = Colors.miniColor()
        label.font = Fonts.sfProDisplayBold(size: HEADER_FONT_SIZE)
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = Fonts.sfProDisplayBold(size: HEADER_FONT_SIZE)
        btn.setTitle(Localizable.more_button_title(), for: .normal)
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
}

//MARK: - Private methods
extension EventsTypeHeaderHeader {
    func setupLabel() {
        self.addSubview(moreButton)
        self.addSubview(header)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        moreButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.right.equalToSuperview().inset(MORE_BUTTON_RIGHT_INSET)
            $0.width.equalTo(MORE_BUTTON_WIDTH)
        }
        
        header.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(HEADER_LEFT_OFFSET)
            $0.right.equalTo(moreButton.snp.left)
        }
    }
}

//MARK: Actions
extension EventsTypeHeaderHeader {
    @objc
    private func moreAction() {
        btnAction?()
    }
}
