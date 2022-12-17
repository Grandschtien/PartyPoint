//
//  RegisterView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 17.12.2022.
//

import SnapKit

private let REGISTRATION_LABEL_HEIGHT: CGFloat = 40
private let USER_IMAGE_TOP_OFFSET: CGFloat = 15
private let USER_IMAGE_SIDE_SIZE: CGFloat = 150
private let PHOTO_LABEL_HEIGHT: CGFloat = 60
private let PHOTO_LABEL_BOTTTOM_OFFSET: CGFloat = 10
private let PHOTO_LABEL_WIDTH: CGFloat = 218
private let DYNAMIC_REGISTER_STACK_HORIZONTAL_OFFSETS: CGFloat = 30
private let DYNAMIC_REGISTER_STACK_BOTTOM_OFFSET: CGFloat = 10
private let REGISTER_BUTTON_HORIZONTAL_OFFSET: CGFloat = 30
private let REGISTER_BUTTON_TOP_OFFFSET: CGFloat = 22
private let REGISTER_BUTTON_HEIGHT: CGFloat = 56

final class RegisterView: UIView {
    
    typealias RegisterClosure = ([String?]) -> Void
    
    //MARK: Actions
    private var backAction: EmptyClosure?
    private var registerAction: RegisterClosure?
    private var photoAction: EmptyClosure?
    private var backActionClosure: EmptyClosure?
    
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
        label.font = Fonts.sfProDisplayBold(size: 36)
        label.text = Localizable.registration_screen_title()
        return label
    }()
    
    private let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.backgroundColor = Colors.miniColor()
        imageView.image = Images.personPhoto()
        return imageView
    }()
    
    private let photoLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.sfProDisplayBold(size: 14)
        label.text = Localizable.photo_label_title()
        label.textColor = Colors.miniColor()
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    private let dynnamicRegisterStack: DynamicStackWithTF = {
        let placeholders = [
            Localizable.name_title_registration(),
            Localizable.surname_title_registration(),
            Localizable.email_title_registration(),
            Localizable.password_title_registration(),
            Localizable.check_password_title_registration()
        ]
        let stack = DynamicStackWithTF(placeholders: placeholders)
        return stack
    }()
    
    private lazy var registerButton: AppButton = {
        let button = AppButton(withTitle: Localizable.register_button_title())
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var bottomScrollConstraint: Constraint?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImage.layer.cornerRadius = userImage.frame.height / 2
        let height = userImage.frame.height + photoLabel.frame.height + dynnamicRegisterStack.frame.height + registerButton.frame.height * 2 + 20
        scrollView.contentSize = CGSize(width: view.frame.width, height: height)
    }
    
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
}

private extension RegisterView {
    func setupUI() {
        self.backgroundColor = Colors.mainColor()
        self.addTapRecognizer(target: self, action: #selector(endEnditing))
        
        addSubviews()
   
        let countOfTf = dynnamicRegisterStack.textFields.count
        dynnamicRegisterStack.textFields[countOfTf - 1].isSecureTextEntry = true
        dynnamicRegisterStack.textFields[countOfTf - 2].isSecureTextEntry = true
        setupConstraints()
    }
    
    func addSubviews() {
        self.addSubview(navigationBar)
        navigationBar.addSubview(registrationLabel)
        self.addSubview(scrollView)
        scrollView.addSubview(userImage)
        scrollView.addSubview(photoLabel)
        scrollView.addSubview(dynnamicRegisterStack)
        scrollView.addSubview(registerButton)
        
    }
    
    func setupConstraints() {
        navigationBar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
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
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.width.equalTo(USER_IMAGE_SIDE_SIZE.scale())
        }
        
        photoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(PHOTO_LABEL_HEIGHT.scale())
            $0.top.equalTo(userImage.snp.bottom).offset(PHOTO_LABEL_BOTTTOM_OFFSET.scale())
            $0.width.equalTo(PHOTO_LABEL_WIDTH.scale())
        }
        
        dynnamicRegisterStack.snp.makeConstraints {
            $0.left.equalToSuperview().offset(DYNAMIC_REGISTER_STACK_HORIZONTAL_OFFSETS.scale())
            $0.right.equalToSuperview().inset(DYNAMIC_REGISTER_STACK_HORIZONTAL_OFFSETS.scale())
            $0.centerX.equalToSuperview()
            $0.top.equalTo(photoLabel.snp.bottom).offset(DYNAMIC_REGISTER_STACK_BOTTOM_OFFSET.scale())
        }
        
        registerButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(REGISTER_BUTTON_HORIZONTAL_OFFSET.scale())
            $0.left.equalToSuperview().offset(REGISTER_BUTTON_HORIZONTAL_OFFSET.scale())
            $0.top.equalTo(dynnamicRegisterStack.snp.bottom).offset(REGISTER_BUTTON_TOP_OFFFSET.scale())
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
extension RegisterView {
    func setBackAction(_ action: @escaping EmptyClosure) {
        self.backAction = action
    }
    
    func setRegisterAction(_ action: @escaping RegisterClosure) {
        self.registerAction = action
    }
    
    @objc
    func registerButtonTapped() {
        let registerInfo = dynnamicRegisterStack.textFields.map { tf in
            return tf.text
        }
        registerAction?(registerInfo)
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
                self?.view.layoutIfNeeded()
            }
        }
    }
    @objc
    func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.bottomScrollConstraint?.layoutConstraints[0].constant = 0
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc
    func endEnditing() {
        view.endEditing(false)
    }
}
