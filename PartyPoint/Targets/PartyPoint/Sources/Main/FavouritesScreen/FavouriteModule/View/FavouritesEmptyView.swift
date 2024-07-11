//
//  FavouritesEmptyView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 08.03.2023.
//

import SnapKit
import UIKit
import PartyPointResources

private let TITLE_FONT_SIZE: CGFloat = 16.scale()
private let SUBTITLE_FONT_SIZE: CGFloat = 14.scale()
private let ICON_SIZE: CGFloat = 100.scale()
private let STACK_VIEW_HORIZONTAL_INSETS: CGFloat = 55
private let STACK_VIEW_SPACING: CGFloat = 5

final class FavouritesEmptyView: UIView {
    private let titleLabel = UILabel()
    private let subtitle = UILabel()
    private let icon = UIImageView()
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
}

private extension FavouritesEmptyView {
    func setupUI() {
        self.backgroundColor = PartyPointResourcesAsset.mainColor.color
        self.addSubview(stackView)
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitle)
        
        setupStackView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupIcon()
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
        
        [titleLabel, subtitle].forEach { label in
            label.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
    }
    
    func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = STACK_VIEW_SPACING
        stackView.alignment = .center
    }
    
    func setupTitleLabel() {
        titleLabel.text = PartyPointResourcesStrings.Localizable.noFavoritesTitle
        titleLabel.font = PartyPointResourcesFontFamily.SFProDisplay.bold.font(size: TITLE_FONT_SIZE)
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
    }
    
    func setupSubtitleLabel() {
        subtitle.text = PartyPointResourcesStrings.Localizable.noFavoritesSubtitle
        subtitle.font = PartyPointResourcesFontFamily.SFProDisplay.medium.font(size: SUBTITLE_FONT_SIZE)
        subtitle.numberOfLines = 2
        subtitle.textAlignment = .center
    }
    
    func setupIcon() {
        icon.image = PartyPointResourcesAsset.noFavourties.image
    }
}
