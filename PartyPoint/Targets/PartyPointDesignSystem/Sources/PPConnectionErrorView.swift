//
//  PPConnectionErrorView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 08.03.2023.
//

import Foundation
import UIKit
import SnapKit
import PartyPointResources

private let TITLE_FONT_SIZE: CGFloat = 16.scale()
private let SUBTITLE_FONT_SIZE: CGFloat = 14.scale()
private let ICON_SIZE: CGFloat = 75.scale()
private let STACK_VIEW_HORIZONTAL_INSETS: CGFloat = 55
private let STACK_VIEW_SPACING: CGFloat = 5
private let REFRESH_BUTTON_HEIGHT: CGFloat = 46.scale()
private let REFRESH_BUTTON_TOP_OFFSET: CGFloat = 15

final class PPConnectionErrorView: UIView {
    private var refreshAction: (() -> Void)?
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let icon = UIImageView()
    private let stackView = UIStackView()
    private let refreshButton = PPButton(style: .primary, size: .m)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setRefreshAction(_ action: @escaping (() -> Void)) {
        self.refreshAction = action
    }
    
    func updateView(withError reason: String) {
        subtitleLabel.text = reason
    }
}

private extension PPConnectionErrorView {
    func setupUI() {
        self.backgroundColor = PartyPointResourcesAsset.mainColor.color
        self.addSubview(stackView)
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(refreshButton)
        
        setupStackView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupIcon()
        setupButton()
        setupConstraints()
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(STACK_VIEW_HORIZONTAL_INSETS)
        }
        
        icon.snp.makeConstraints {
            $0.size.equalTo(ICON_SIZE)
        }
        
        [titleLabel, subtitleLabel].forEach { label in
            label.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
        
        refreshButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(REFRESH_BUTTON_HEIGHT)
        }
    }
    
    func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = STACK_VIEW_SPACING
        stackView.alignment = .center
        stackView.setCustomSpacing(REFRESH_BUTTON_TOP_OFFSET, after: subtitleLabel)
    }
    
    func setupTitleLabel() {
        titleLabel.text = PartyPointResourcesStrings.Localizable.error
        titleLabel.font = PartyPointResourcesFontFamily.SFProDisplay.bold.font(size: TITLE_FONT_SIZE)
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
    }
    
    func setupSubtitleLabel() {
        subtitleLabel.font = PartyPointResourcesFontFamily.SFProDisplay.medium.font(size: SUBTITLE_FONT_SIZE)
        subtitleLabel.numberOfLines = 2
        subtitleLabel.textAlignment = .center
    }
    
    func setupIcon() {
        icon.image = PartyPointResourcesAsset.connectionError.image
    }
    
    func setupButton() {
        refreshButton.setTitle(PartyPointResourcesStrings.Localizable.refresh, for: .normal)
        refreshButton.addTarget(self, action: #selector(refreshActionHandler), for: .touchUpInside)
    }
}

private extension PPConnectionErrorView {
    @objc func refreshActionHandler() {
        refreshAction?()
    }
}
