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
        
        contentView.setRegisterAction { [weak self] name, surname, email, dob, city, passwd, checkPasswd, image  in
            self?.output.registeButtonPressed(registerInfo: (name: name,
                                                             surname: surname,
                                                             email: email,
                                                             dob: dob,
                                                             city: city,
                                                             passwd: passwd,
                                                             checkPasswd: checkPasswd,
                                                             image: image?.jpegData(compressionQuality: 1)))
            self?.contentView.hideKeyboard()
        }
        
        contentView.setSelectDateAction { [weak self] in
            self?.output.showCalendarPicker()
        }
        
        contentView.setChoosePhotoAction { [weak self] in
            guard let `self` = self else { return }
            self.output.showImagePicker()
        }
    }
}

extension RegisterViewController: RegisterViewInput {
    func imageSelected(imageData: Data) {
        guard let image = UIImage(data: imageData) else { return }
        contentView.setUserPhoto(image: image)
    }
    
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
    
    func showThatDateIsIncorrect(reason: String) {
        contentView.showThatDateIsIncorrect(reason: reason)
    }
}
