//
//  ProfileInfoStackView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//

import SnapKit
import UIKit
import PartyPointDesignSystem
import PartyPointResources

private let AVATAR_SIZE: CGFloat = 50.scale()
private let EMAIL_FONT_SIZE: CGFloat = 14.scale()
private let NAMEL_FONT_SIZE: CGFloat = 16.scale()
private let VERTICAL_STACK_SPACING: CGFloat = 7
private let HORIZONTAL_STACK_SPACING: CGFloat = 13
private let HORIZONTAL_STACK_HORIZONTAL_OFFFSETS: CGFloat = 20

final class ProfileInfoStackView: UIView {
    private let avatarImageView = AcyncImageView(placeHolderType: .profile)
    private let horizontalStack = UIStackView()
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private let spacer = UIView()
    private let verticalStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(withInfo info: ProfileInfo) {
        self.avatarImageView.setImage(url: info.imageUrl)
        self.nameLabel.text = info.fullName
        self.emailLabel.text = info.email
    }
}

private extension ProfileInfoStackView {
    func setupUI() {
        self.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(avatarImageView)
        horizontalStack.addArrangedSubview(verticalStack)
        verticalStack.addArrangedSubview(nameLabel)
        verticalStack.addArrangedSubview(emailLabel)
        
        setupVerticalStack()
        setupHorizontalStack()
        setupImageView()
        setupNameLabel()
        setupEmailLabel()
        
        setupConstraints()
    }
    
    func setupConstraints() {
        horizontalStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints {
            $0.size.equalTo(AVATAR_SIZE)
        }
    }
    
    func setupVerticalStack() {
        verticalStack.axis = .vertical
        verticalStack.spacing = VERTICAL_STACK_SPACING
    }
    
    func setupHorizontalStack() {
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = HORIZONTAL_STACK_SPACING
        horizontalStack.alignment = .center
    }
    
    func setupImageView() {
        avatarImageView.layer.cornerRadius = AVATAR_SIZE / 2
        avatarImageView.backgroundColor = PartyPointResourcesAsset.miniColor.color
        avatarImageView.tintColor = PartyPointResourcesAsset.miniColor.color
        avatarImageView.clipsToBounds = true
    }
    
    func setupEmailLabel() {
        emailLabel.textColor = PartyPointResourcesAsset.miniColor.color
        emailLabel.font = PartyPointResourcesFontFamily.SFProDisplay.regular.font(size: EMAIL_FONT_SIZE)
    }
    
    func setupNameLabel() {
        nameLabel.textColor = PartyPointResourcesAsset.miniColor.color
        nameLabel.font = PartyPointResourcesFontFamily.SFProDisplay.semibold.font(size: NAMEL_FONT_SIZE)
    }
}
