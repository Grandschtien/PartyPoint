//
//  ProfileContentView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.02.2023.
//

import SnapKit

private let HORIZONTAL_STACK_SPACING: CGFloat = 20
private let VERTICAL_STACK_SPACING: CGFloat = 20
private let VERTICAL_STACK_ELEMENT_HEIGHT: CGFloat = 84.scale()
private let VERTICAL_STACK_ELEMENT_WIDTH: CGFloat = 157.scale()
private let INVITE_FRIEND_VIEW_HEIGHT: CGFloat = 75.scale()
private let VERTICAL_STACK_TOP_OFFSET: CGFloat = 30
private let VERTICAL_STACK_HORIZONTAL_OFFSET: CGFloat = 20
private let PROFILE_INFO_HORIZONTAL_OFFSET: CGFloat = 20
private let PROFILE_INFO_TOP_OFFSET: CGFloat = 15
private let BUTTON_HEIGHT: CGFloat = 44.scale()

final class ProfileContentView: UIView {
    
    private var exitAction: EmptyClosure?
    
    private let navigationBar = PlainNavigationBar()
    private let profileInfo = ProfileInfoStackView()
    private let changeCityView = ManageProfileView()
    private let changePasswordView = ManageProfileView()
    private let horizontalStackView = UIStackView()
    private let aboutAppView = ManageProfileView()
    private let exitButton = PPButton(style: .ghost(titleColor: Colors.miniColor() ?? .white), size: .s)
    private let verticalStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(withInfo info: ProfileInfo) {
        profileInfo.configure(withInfo: info)
    }
    
    func setBackAction(_ action: @escaping EmptyClosure) {
        navigationBar.setBackAction(action)
    }
    
    func setExitButtonLoader(isLoading: Bool) {
        exitButton.isLoading = isLoading
    }
    
    func setExitAction(_ action: @escaping EmptyClosure) {
        self.exitAction = action
    }
}

private extension ProfileContentView {
    func setupUI() {
        self.backgroundColor = Colors.mainColor()
        self.addSubview(navigationBar)
        self.addSubview(profileInfo)
        self.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(aboutAppView)
        verticalStackView.addArrangedSubview(exitButton)
        
        horizontalStackView.addArrangedSubview(changeCityView)
        horizontalStackView.addArrangedSubview(changePasswordView)
        
        setupNavigationBar()
        setupVerticalStack()
        setupHorizontalStack()
        setupChangeCityView()
        setupChangePasswordView()
        setupInviteFriendVeiw()
        setupExitButton()
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        navigationBar.snp.makeConstraints {
            $0.height.equalTo(navigationBar.height)
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(statusBarFrame.height)
        }
        
        profileInfo.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(PROFILE_INFO_HORIZONTAL_OFFSET)
            $0.top.equalTo(navigationBar.snp.bottom).offset(PROFILE_INFO_TOP_OFFSET)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(profileInfo.snp.bottom).offset(VERTICAL_STACK_TOP_OFFSET)
            $0.left.right.equalToSuperview().inset(VERTICAL_STACK_HORIZONTAL_OFFSET)
        }
        
        horizontalStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        changeCityView.snp.makeConstraints {
            $0.width.equalTo(VERTICAL_STACK_ELEMENT_WIDTH)
            $0.height.equalTo(VERTICAL_STACK_ELEMENT_HEIGHT)
        }
        
        changePasswordView.snp.makeConstraints {
            $0.width.equalTo(VERTICAL_STACK_ELEMENT_WIDTH)
            $0.height.equalTo(VERTICAL_STACK_ELEMENT_HEIGHT)
        }
        
        aboutAppView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(INVITE_FRIEND_VIEW_HEIGHT)
        }
        
        exitButton.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(BUTTON_HEIGHT)
        }
    }
    
    func setupExitButton() {
        exitButton.setTitle(Localizable.exit(), for: .normal)
        exitButton.addTarget(self, action: #selector(exitActionHandler), for: .touchUpInside)
    }
    
    func setupNavigationBar() {
        navigationBar.setTitle(Localizable.profile())
    }
    
    func setupChangeCityView() {
        changeCityView.configure(configuration: .changeCity)
    }
    
    func setupChangePasswordView() {
        changePasswordView.configure(configuration: .chnagePassword)
    }
    
    func setupInviteFriendVeiw() {
        aboutAppView.configure(configuration: .aboutApp)
    }
    
    func setupHorizontalStack() {
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = HORIZONTAL_STACK_SPACING
    }
    
    func setupVerticalStack() {
        verticalStackView.axis = .vertical
        verticalStackView.spacing = VERTICAL_STACK_SPACING
    }
}


private extension ProfileContentView {
    @objc
    func exitActionHandler() {
        exitAction?()
    }
    
    @objc
    func deleteAccountActionHandler() {
        
    }
}
