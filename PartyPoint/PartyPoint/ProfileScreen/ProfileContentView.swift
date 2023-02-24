//
//  ProfileContentView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.02.2023.
//

import SnapKit

final class ProfileContentView: UIView {
    private let changeCityView = ManageProfileView()
    private let changePasswordView = ManageProfileView()
    private let inviteFriendView = ManageProfileView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
}

private extension ProfileContentView {
    func setupChangeCityView(){
        changeCityView.configureMainLabel(with: "Город")
        changeCityView.configureManageLabel(with: "Управлять")
    }
    
    func setupChangePasswordView() {
        changePasswordView.configureMainLabel(with: "Пароль")
        changePasswordView.configureManageLabel(with: "Управлять")
    }
    
    func setupInviteFriendVeiw() {
        inviteFriendView.configureMainLabel(with: "Получи доступ ко всем мероприятиям")
        inviteFriendView.configureManageLabel(with: "Пригласить друзей")
    }
    
    func setupUI() {
        self.backgroundColor = Colors.mainColor()
        setupChangeCityView()
        self.addSubview(changeCityView)
        self.addSubview(changePasswordView)
        self.addSubview(inviteFriendView)
    }
}
