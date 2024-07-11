//
//  PlainNavigationBar.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//

import SnapKit
import UIKit
import PartyPointResources

private let BACK_BUTTON_SIZE: CGFloat = 30.scale()
private let BACK_BUTTON_LEFT_OFFSET: CGFloat = 14
private let TITLE_FONT_SIZE: CGFloat = 16.scale()
private let NAV_BAR_HEIGHT: CGFloat = 42.scale()

open class PlainNavigationBar: UIView {
    private var backAction: (() -> Void)?
    
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    
    public var height: CGFloat {
        return NAV_BAR_HEIGHT
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        return nil
    }
    
    public func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
    
    public func setBackAction(_ action: @escaping (() -> Void)) {
        backAction = action
    }
}

private extension PlainNavigationBar {
    func setupBackButton() {
        backButton.setImage(PartyPointResourcesAsset.chevronBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(backActionHandler), for: .touchUpInside)
    }
    
    func setupTitleLabel() {
        titleLabel.textColor = PartyPointResourcesAsset.miniColor.color
        titleLabel.font = PartyPointResourcesFontFamily.SFProDisplay.semibold.font(size: TITLE_FONT_SIZE)
    }
    func setupUI() {
        self.addSubview(titleLabel)
        self.addSubview(backButton)
        
        setupBackButton()
        setupTitleLabel()
        setupConstraints()
    }
    
    func setupConstraints() {
        backButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(BACK_BUTTON_SIZE)
            $0.left.equalToSuperview().offset(BACK_BUTTON_LEFT_OFFSET)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

private extension PlainNavigationBar {
    @objc
    func backActionHandler() {
        backAction?()
    }
}
