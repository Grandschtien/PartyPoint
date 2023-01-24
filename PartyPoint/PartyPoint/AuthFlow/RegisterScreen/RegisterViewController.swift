//
//  RegisterViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import SnapKit

final class RegisterViewController: UIViewController {
    
    private let contentView = RegisterView()
    
    private let output: RegisterViewOutput
    
    init(output: RegisterViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setActions()
    }
}

private extension RegisterViewController {
    func setActions() {
        contentView.setBackAction { [weak self] in
            self?.output.backButtonPressed()
        }
        
        contentView.setRegisterAction { [weak self] name, surname, email, dob, city, passwd, checkPasswd in
            self?.output.registeButtonPressed(registerInfo: (name: name,
                                                             surname: surname,
                                                             email: email,
                                                             dob: dob,
                                                             city: city,
                                                             passwd: passwd,
                                                             checkPasswd: checkPasswd))
            self?.contentView.hideKeyboard()
        }
        
        contentView.setSelectDateAction { [weak self] in
            self?.output.showCalendarPicker()
        }
    }
}

extension RegisterViewController: RegisterViewInput {
    func showLoadingIfNeeded(isLoading: Bool) {
        contentView.setButtonLoading(isLoading: isLoading)
    }
    
    func showWhyRegisterFailed(reason: String) {
        contentView.showRegisterFaild(withReason: reason)
    }
    
    func showNameIsEmpty() {
        contentView.showNameIsEmpty()
    }
    
    func showSurnameIsEmpty() {
        contentView.showSurnameIsEmpty()
    }
    
    func showEmailIsEmpty() {
        contentView.showEmailIsEmpty()
    }
    
    func showDobIsEmpty() {
        contentView.showDobIsEmpty()
    }
    
    func showPasswdIsEmpty() {
        contentView.showPasswdIsEmpty()
    }
    
    func showCheckPasswdIsEmpty() {
        contentView.showCheckPasswdIsEmpty()
    }
    
    func showToPasswordsIsDifferent() {
        contentView.showPasswordIsDifferent()
    }
}
