//
//  CollectionHeader.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.07.2022.
//

import SnapKit
import UIKit
import PartyPointResources

private let HEADER_FONT_SIZE: CGFloat = 24 * SCREEN_SCALE_BY_HEIGHT
private let MORE_BUTTON_RIGHT_INSET: CGFloat = 10
private let MORE_BUTTON_WIDTH: CGFloat = 50.scale()
private let HEADER_LEFT_OFFSET: CGFloat = 10

public final class EventsTypeHeaderHeader: UICollectionReusableView {
    private var moreAction: (() -> Void)?
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.textColor = PartyPointResourcesAsset.miniColor.color
        label.font = PartyPointResourcesFontFamily.SFProDisplay.bold.font(size: HEADER_FONT_SIZE)
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = PartyPointResourcesFontFamily.SFProDisplay.bold.font(size: HEADER_FONT_SIZE)
        btn.setTitle(PartyPointResourcesStrings.Localizable.moreButtonTitle, for: .normal)
        btn.addTarget(self, action: #selector(moreActionHandler), for: .touchUpInside)
        return btn
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        return nil
    }
    
    public func configure(withHeader header: String, isMoreButtonHidden: Bool) {
        self.header.text = header
        self.moreButton.isHidden = isMoreButtonHidden
    }
    
    public func setMoreAction(_ action: @escaping (() -> Void)) {
        self.moreAction = action
    }
}

//MARK: - Private methods
extension EventsTypeHeaderHeader {
    func setupLabel() {
        self.addSubview(moreButton)
        self.addSubview(header)
        
        setupConstraints()
        moreButton.isHidden = true
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
    private func moreActionHandler() {
        moreAction?()
    }
}
