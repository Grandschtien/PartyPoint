//
//  PPProfileNavigationBar.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.02.2023.
//

import SnapKit
import UIKit

private let NAVIGATION_BAR_HEIGHT: CGFloat = 42.scale()
private let AVATAR_IMAGE_SIZE: CGFloat = 30.scale()
private let NAME_LABEL_FONT_SIZE: CGFloat = 16.scale()
private let NAME_LABEL_LEFT_OFFSET: CGFloat = 14.scale()
private let ARROW_SIZE: CGFloat = 28.scale()
private let ARROW_RIGHT_INSET: CGFloat = 15
private let AVATAR_LEFT_OFFSET: CGFloat = 15

final class PPProfileNavigationBar: UIView {
    private var openProfileAction: EmptyClosure?
    
    private let avatarImageView = AcyncImageView(placeHolderType: .profileMain)
    private let nameLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let horizontalStack = UIStackView()
    
    var height: CGFloat {
        return NAVIGATION_BAR_HEIGHT
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(name: String?, avatar: String?) {
        guard let avatar = avatar else {
            self.nameLabel.text = name
            self.avatarImageView.setDefaultImage()
            return
        }
        
        self.avatarImageView.setImage(url: URL(string: avatar))
        self.nameLabel.text = name
    }
    
    func setOpenProfileAction(_ action: @escaping EmptyClosure) {
        self.openProfileAction = action
    }
}

private extension PPProfileNavigationBar {
    func setupUI() {
        self.isUserInteractionEnabled = true
        self.addTapRecognizer(target: self, #selector(openProfileActionHandler))
        
        self.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(avatarImageView)
        horizontalStack.addArrangedSubview(nameLabel)
        horizontalStack.addArrangedSubview(arrowImageView)
        
        setupStack()
        setupAvatarImageView()
        setupNameLabel()
        setupArrowImageView()
        
        setupConstraints()
    }
    
    func setupConstraints() {
        let labelWidth = UIScreen.main.bounds.width - ARROW_RIGHT_INSET * 2 - ARROW_SIZE - AVATAR_IMAGE_SIZE - NAME_LABEL_LEFT_OFFSET
        horizontalStack.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(ARROW_RIGHT_INSET)
            $0.top.bottom.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints {
            $0.size.equalTo(AVATAR_IMAGE_SIZE)
            $0.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalTo(labelWidth)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(ARROW_SIZE)
        }
    }
    
    func setupStack() {
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.setCustomSpacing(NAME_LABEL_LEFT_OFFSET, after: avatarImageView)
    }
    
    func setupAvatarImageView() {
        avatarImageView.layer.cornerRadius = AVATAR_IMAGE_SIZE / 2
        avatarImageView.image = PartyPointAsset.profileImage.image
        avatarImageView.backgroundColor = PartyPointAsset.miniColor.color
        avatarImageView.clipsToBounds = true
    }
    
    func setupNameLabel() {
        nameLabel.font = PartyPointFontFamily.SFProDisplay.semibold.font(size: NAME_LABEL_FONT_SIZE)
        nameLabel.textColor = PartyPointAsset.miniColor.color
        nameLabel.numberOfLines = 1
    }
    
    func setupArrowImageView() {
        arrowImageView.image = PartyPointAsset.calendarChevron.image
    }
}

private extension PPProfileNavigationBar {
    @objc
    func openProfileActionHandler() {
        openProfileAction?()
    }
}
