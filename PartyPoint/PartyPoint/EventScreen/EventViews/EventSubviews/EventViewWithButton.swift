//
//  EventViewWithButton.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 23.08.2022.
//

import SnapKit

private let SUBVIEWS_TOP_OFFSET: CGFloat = 8
private let BUTTON_HEIGHT: CGFloat = 57.scale()
private let FONT_SIZE: CGFloat = 15.scale()

final class EventViewWithButton: DefaultEventView {
    private let subtitleLabel = UILabel()
    private let actionButton = PPButton(style: .primary, size: .m)
    
    override func setupUI() {
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(actionButton)
        super.setupUI()
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = Fonts.sfProDisplayBold(size: FONT_SIZE)
    }
    
    override var titleText: String { return "" }
    
    override func setupConstraints() {
        super.setupConstraints()
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(SUBVIEWS_TOP_OFFSET)
            $0.left.right.equalToSuperview()
        }
        
        actionButton.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(SUBVIEWS_TOP_OFFSET)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(BUTTON_HEIGHT)
            $0.bottom.equalToSuperview()
        }
    }
    
    func configure(forCost cost: CostEventInfo) {
        titleLabel.text = cost.title
        subtitleLabel.text = cost.cost.isEmpty ? Localizable.no_information() : cost.cost
        actionButton.setTitle(cost.buttonTitle, for: .normal)
    }
}
