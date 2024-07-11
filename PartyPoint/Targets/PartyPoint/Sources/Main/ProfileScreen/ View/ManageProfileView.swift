//
//  ManageProfileView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.02.2023.
//

import SnapKit
import UIKit
import PartyPointResources
import PartyPointDesignSystem

private let VIEW_CONRNER_RADIUS: CGFloat = 8
private let TITLE_LABEL_FONT_SIZE: CGFloat = 16.scale()
private let TITLE_LABEL_TOP_OFFSET: CGFloat = 13
private let TITLE_LABEL_LEFT_OFFSET: CGFloat = 13
private let MANAGE_LABEL_BOTTOM_INSET: CGFloat = 10
private let MANAGE_LABEL_LEFT_OFFSET: CGFloat = 13
private let MANAGE_LABEL_FONT_SIZE: CGFloat = 12.scale()
private let ARROW_SIZE: CGFloat = 14.scale()

final class ManageProfileView: UIView {
    private let titleLabel = UILabel()
    private let manageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(configuration: ManageProfileConfiguration) {
        self.titleLabel.text = configuration.title
        self.manageLabel.set(text: configuration.subtitle, rightIcon: PartyPointResourcesAsset.manageChevron.image)
    }
}

private extension ManageProfileView {
    func setupUI() {
        self.addSubview(titleLabel)
        self.addSubview(manageLabel)
        
        setupSelf()
        setupTitleLabel()
        setupManageLabel()
        setupConstraints()
    }
    
    func setupSelf() {
        self.backgroundColor = PartyPointResourcesAsset.miniColor.color.withAlphaComponent(0.1)
        self.layer.cornerRadius = VIEW_CONRNER_RADIUS
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(TITLE_LABEL_TOP_OFFSET)
        }
        
        manageLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(MANAGE_LABEL_LEFT_OFFSET)
            $0.bottom.equalToSuperview().inset(MANAGE_LABEL_BOTTOM_INSET)
        }

    }

    func setupTitleLabel() {
        titleLabel.font = PartyPointResourcesFontFamily.SFProDisplay.semibold.font(size: TITLE_LABEL_FONT_SIZE)
        titleLabel.textColor = PartyPointResourcesAsset.miniColor.color
        titleLabel.sizeToFit()
    }
    
    func setupManageLabel() {
        manageLabel.font = PartyPointResourcesFontFamily.SFProDisplay.medium.font(size: MANAGE_LABEL_FONT_SIZE)
        manageLabel.textColor = PartyPointResourcesAsset.manageLabelColor.color
        manageLabel.sizeToFit()
    }
}
