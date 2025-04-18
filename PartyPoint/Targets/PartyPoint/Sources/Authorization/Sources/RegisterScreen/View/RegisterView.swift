//
//  RegisterView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 17.12.2022.
//

import SnapKit
import UIKit
import PartyPointResources
import PartyPointDesignSystem

private let REGISTRATION_LABEL_HEIGHT: CGFloat = 40
private let USER_IMAGE_TOP_OFFSET: CGFloat = 15
private let USER_IMAGE_SIDE_SIZE: CGFloat = 150
private let PHOTO_LABEL_HEIGHT: CGFloat = 60
private let PHOTO_LABEL_BOTTTOM_OFFSET: CGFloat = 10
private let PHOTO_LABEL_WIDTH: CGFloat = 218
private let HORIZONTAL_OFFSETS: CGFloat = 30
private let NAME_TF_TOP_OFFSET: CGFloat = 10
private let TF_TOP_OFFSET: CGFloat = 22
private let REGISTER_BUTTON_HORIZONTAL_OFFSET: CGFloat = 30
private let REGISTER_BUTTON_TOP_OFFFSET: CGFloat = 22
private let REGISTER_BUTTON_HEIGHT: CGFloat = 56

final class RegisterView: UIView {
    typealias RegisterClosure = (String?, String?, String?, String?, String?, String?, String?, UIImage?) -> Void
    //MARK: Actions
    private var backAction: (() -> Void)?
    private var registerAction: RegisterClosure?
    private var selectDateOfBirthAction: (() -> Void)?
    private var photoAction: (() -> Void)?
    private var backActionClosure: (() -> Void)?
    
    private lazy var navigationBar: NavigationBarWithLogoAndActions = {
        let navigationBar = NavigationBarWithLogoAndActions(
            frame: .zero,
            buttons: [.back],
            isImageNeed: false
        )
        
        navigationBar.setBackAction { [weak self] in
            self?.backAction?()
        }
        
        return navigationBar
    }()
    
    private lazy var registrationLabel: UILabel = {
        let label = UILabel()
        label.font = PartyPointResourcesFontFamily.SFProDisplay.bold.font(size: 36)
        label.text = PartyPointResourcesStrings.Localizable.registrationScreenTitle
        return label
    }()
    
    private let userImage = UIImageView()
    
    private let photoLabel: UILabel = {
        let label = UILabel()
        label.font = PartyPointResourcesFontFamily.SFProDisplay.bold.font(size: 14)
        label.text = PartyPointResourcesStrings.Localizable.photoLabelTitle
        label.textColor = PartyPointResourcesAsset.miniColor.color
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    
    private let nameTextField = PPTextField()
    private let surnameTextField = PPTextField()
    private let emailTextField = PPTextField()
    private let dobTextField = PPTextField()
    private let cityTextField = PPTextField()
    private let passwordTextField = PPTextField()
    private let checkPasswordTextField = PPTextField()

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    private lazy var registerButton: PPButton = {
        let button = PPButton(style: .primary, size: .l)
        button.setTitle(PartyPointResourcesStrings.Localizable.registerButtonTitle, for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var bottomScrollConstraint: Constraint?
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupKeyboardObservers()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    deinit {
        removeKeyboardObservers()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImage.layer.cornerRadius = userImage.frame.height / 2
        let textFieldsHeights = [nameTextField, surnameTextField, emailTextField, dobTextField, cityTextField, passwordTextField, checkPasswordTextField].reduce(into: 0) { partialResult, tf in
            partialResult += tf.frame.height + 22
        }
        let height = userImage.frame.height + photoLabel.frame.height + textFieldsHeights - 22 + registerButton.frame.height * 2 + 20
        scrollView.contentSize = CGSize(width: self.frame.width, height: height)
    }
}

//MARK: Public methods
extension RegisterView {
    func setBackAction(_ action: @escaping (() -> Void)) {
        self.backAction = action
    }
    
    func setRegisterAction(_ action: @escaping RegisterClosure) {
        self.registerAction = action
    }
    
    func setSelectDateAction(_ action: @escaping (() -> Void)) {
        self.selectDateOfBirthAction = action
    }
    
    func setChoosePhotoAction(_ action: @escaping (() -> Void)) {
        self.photoAction = action
    }
    
    func showNameIsEmpty() {
        nameTextField.displayState = .error(PartyPointResourcesStrings.Localizable.fillInThisField)
    }
    
    func showSurnameIsEmpty() {
        surnameTextField.displayState = .error(PartyPointResourcesStrings.Localizable.fillInThisField)
    }
    
    func showEmailIsEmpty() {
        emailTextField.displayState = .error(PartyPointResourcesStrings.Localizable.fillInThisField)
    }
    
    func showDobIsEmpty() {
        dobTextField.displayState = .error(PartyPointResourcesStrings.Localizable.fillInThisField)
    }
    
    func showPasswdIsEmpty() {
        passwordTextField.displayState = .error(PartyPointResourcesStrings.Localizable.fillInThisField)
    }
    
    func showCheckPasswdIsEmpty() {
        checkPasswordTextField.displayState = .error(PartyPointResourcesStrings.Localizable.fillInThisField)
    }
    
    func showRegisterFaild(withReason reason: String) {
        emailTextField.displayState = .error(reason)
    }
    
    func showPasswordIsDifferent() {
        passwordTextField.displayState = .error(PartyPointResourcesStrings.Localizable.passwordDoesntMatch)
        checkPasswordTextField.displayState = .error(PartyPointResourcesStrings.Localizable.passwordDoesntMatch)
    }
    
    func hideKeyboard() {
        endEnditing()
    }
    
    func setButtonLoading(isLoading: Bool) {
        registerButton.isLoading = isLoading
    }
    
    func showThatDateIsIncorrect(reason: String) {
        dobTextField.displayState = .error(reason)
    }
    
    func setUserPhoto(image: UIImage) {
        userImage.image = image
    }
}


// MARK: Private methods
private extension RegisterView {
    func setupUI() {
        self.backgroundColor = PartyPointResourcesAsset.mainColor.color
        self.addTapRecognizer(target: self, action: #selector(endEnditing))
        
        addSubviews()
        setupTextFields()
        setupUserImage()
        setupConstraints()
    }
    
    func setupTextFields() {
        nameTextField.placeholder = PartyPointResourcesStrings.Localizable.nameTitleRegistration
        surnameTextField.placeholder = PartyPointResourcesStrings.Localizable.surnameTitleRegistration
        emailTextField.placeholder = PartyPointResourcesStrings.Localizable.emailTitleRegistration
        dobTextField.placeholder = PartyPointResourcesStrings.Localizable.dateOfBirth
        cityTextField.placeholder = PartyPointResourcesStrings.Localizable.city
        passwordTextField.placeholder = PartyPointResourcesStrings.Localizable.passwordTitleRegistration
        checkPasswordTextField.placeholder = PartyPointResourcesStrings.Localizable.checkPasswordTitleRegistration
        
        passwordTextField.mode = .secureMode
        checkPasswordTextField.mode = .secureMode
        
        passwordTextField.isSecureTextEntry = true
        checkPasswordTextField.isSecureTextEntry = true
        
        nameTextField.autocorrectionType = .no
        surnameTextField.autocorrectionType = .no
        emailTextField.autocorrectionType = .no
        dobTextField.autocorrectionType = .no
        cityTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
        checkPasswordTextField.autocorrectionType = .no
        
        dobTextField.delegate = self
    }
    
    func addSubviews() {
        self.addSubview(navigationBar)
        navigationBar.addSubview(registrationLabel)
        self.addSubview(scrollView)
        scrollView.addSubview(userImage)
        scrollView.addSubview(photoLabel)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(surnameTextField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(dobTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(checkPasswordTextField)
        scrollView.addSubview(registerButton)
        
    }
    
    func setupUserImage() {
        userImage.clipsToBounds = true
        userImage.isUserInteractionEnabled = true
        userImage.backgroundColor = PartyPointResourcesAsset.miniColor.color
        userImage.image = PartyPointResourcesAsset.personPhoto.image
        userImage.layer.borderWidth = 1.0
        userImage.layer.borderColor = PartyPointResourcesAsset.miniColor.color.cgColor
        userImage.addTapRecognizer(target: self, action: #selector(choosePhoto))
    }
    
    func setupConstraints() {
        navigationBar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
        }
        
        registrationLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(REGISTRATION_LABEL_HEIGHT.scale())
        }
        
        scrollView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(navigationBar.snp.bottom)
            bottomScrollConstraint = $0.bottom.equalToSuperview().constraint
        }
        
        userImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(USER_IMAGE_TOP_OFFSET.scale())
            $0.centerX.equalTo(self.snp.centerX)
            $0.height.width.equalTo(USER_IMAGE_SIDE_SIZE.scale())
        }
        
        photoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(PHOTO_LABEL_HEIGHT.scale())
            $0.top.equalTo(userImage.snp.bottom).offset(PHOTO_LABEL_BOTTTOM_OFFSET.scale())
            $0.width.equalTo(PHOTO_LABEL_WIDTH.scale())
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(photoLabel.snp.bottom).offset(NAME_TF_TOP_OFFSET)
            $0.left.right.equalToSuperview().inset(HORIZONTAL_OFFSETS)
            $0.centerX.equalToSuperview()
        }
        
        surnameTextField.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(HORIZONTAL_OFFSETS)
            $0.top.equalTo(nameTextField.snp.bottom).offset(TF_TOP_OFFSET)
        }
        
        emailTextField.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(HORIZONTAL_OFFSETS)
            $0.top.equalTo(surnameTextField.snp.bottom).offset(TF_TOP_OFFSET)
        }
        
        dobTextField.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(HORIZONTAL_OFFSETS)
            $0.top.equalTo(emailTextField.snp.bottom).offset(TF_TOP_OFFSET)
        }

        passwordTextField.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(HORIZONTAL_OFFSETS)
            $0.top.equalTo(dobTextField.snp.bottom).offset(TF_TOP_OFFSET)
        }
        
        checkPasswordTextField.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(HORIZONTAL_OFFSETS)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(TF_TOP_OFFSET)
        }

        registerButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(REGISTER_BUTTON_HORIZONTAL_OFFSET.scale())
            $0.left.equalToSuperview().offset(REGISTER_BUTTON_HORIZONTAL_OFFSET.scale())
            $0.top.equalTo(checkPasswordTextField.snp.bottom).offset(REGISTER_BUTTON_TOP_OFFFSET.scale())
            $0.height.equalTo(REGISTER_BUTTON_HEIGHT.scale())
        }
    }
    
    func setupKeyboardObservers() {
        NotificationCenterManager.addObserver(observer: self,
                                              selector: #selector(keyboardWillShow(_:)),
                                              name: UIWindow.keyboardWillShowNotification,
                                              object: nil)
        NotificationCenterManager.addObserver(observer: self,
                                              selector: #selector(keyboardWillHide(_:)),
                                              name: UIWindow.keyboardWillHideNotification,
                                              object: nil)
    }
    
    func removeKeyboardObservers() {
        NotificationCenterManager.removeObserver(observer: self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenterManager.removeObserver(observer: self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
}

//MARK: Actions
private extension RegisterView {
    @objc
    func registerButtonTapped() {
        registerAction?(nameTextField.text,
                        surnameTextField.text,
                        emailTextField.text,
                        dobTextField.text,
                        cityTextField.text,
                        passwordTextField.text,
                        checkPasswordTextField.text,
                        userImage.image)
    }
}

//MARK: Keyboard actions
extension RegisterView {
    @objc
    func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.bottomScrollConstraint?.layoutConstraints[0].constant == 0 {
            UIView.animate(withDuration: 0.4) { [weak self] in
                self?.bottomScrollConstraint?.layoutConstraints[0].constant -= keyboardFrame.height
                self?.layoutIfNeeded()
            }
        }
    }
    @objc
    func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.bottomScrollConstraint?.layoutConstraints[0].constant = 0
            self?.layoutIfNeeded()
        }
    }
    
    @objc
    func endEnditing() {
        self.endEditing(false)
    }
    
    @objc
    func choosePhoto() {
        photoAction?()
    }
}

extension RegisterView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == dobTextField {
            if string == "." {
                return true
            }
            
            if (dobTextField.text?.count == 2) || (dobTextField.text?.count == 5) {
                if !(string == "") {
                    dobTextField.text = (dobTextField.text)! + "."
                }
            }
            return !((textField.text?.count ?? 0) > 9 && (string.count ) > range.length)
        }
        else {
            return true
        }
    }
}
