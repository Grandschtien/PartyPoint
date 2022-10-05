//
//  EnterViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit
import SnapKit

private let ENTRY_LABEL_HORIZONTAL_OFFSETS: CGFloat = 42
private let ENTRY_LABEL_HEIGHT: CGFloat = 108
private let ENTRY_LABEL_WIDTH: CGFloat = 180
private let ENTRY_LABEL_TOP_OFFSET: CGFloat = 50
private let TF_STACK_HORIZONTAL_OFFSETS: CGFloat = 15
private let TF_STACK_TOP_OFFSET: CGFloat = 35
private let FORGOT_PASSWORD_BUTTON_WIDTH: CGFloat = 120
private let FORGOT_PASSWORD_BUTTON_TOP_OFFSET: CGFloat = 25
private let FORGOT_PASSWORD_BUTTON_HEIGHT: CGFloat = 17
private let FORGOT_PASSWORD_BUTTON_HORIZONTAL_OFFSETS: CGFloat = 30
private let HOW_TO_ENTER_STACK_HORIZONTAL_OFFSETS: CGFloat = 30
private let HOW_TO_ENTER_STACK_TOP_OFFSET: CGFloat = 110


final class EnterViewController: UIViewController {
    
    private lazy var entryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Fonts.sfProDisplayBold(size: 30.scale())
        label.numberOfLines = 3
        label.text = Localizable.entry_label()
        return label
    }()
    
    private lazy var tfStack: DynamicStackWithTF = {
        //TODO: Make localize list
        let placeholders: [String] = [
            Localizable.email_title_registration(),
            Localizable.password_title_registration()
        ]
        let stack = DynamicStackWithTF(frame: .zero, placeholders: placeholders)
        return stack
    }()
    private var topTobottomConstraintOfEntryLabel: Constraint?
    private var topTobottomConstraintOfButton: Constraint?
    
    private lazy var forgotPaaswdButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(Localizable.forgot_password_button_title(), for: .normal)
        btn.titleLabel?.font = Fonts.sfProDisplayBold(size: 14.scale())
        btn.titleLabel?.textColor = Colors.mainColor()?.withAlphaComponent(0.75)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(fogotButtonPressed(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var howToEnterStack: HowToEnterStackView = {
        let stack = HowToEnterStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.delegate = self
        return stack
    }()
    
    private let output: EnterViewOutput
    
    init(output: EnterViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenterManager.addObserver(observer: self,
                                              selector: #selector(keyboardWillShow(_:)),
                                              name: UIWindow.keyboardWillShowNotification,
                                              object: nil)
        NotificationCenterManager.addObserver(observer: self,
                                              selector: #selector(keyboardWillHide(_:)),
                                              name: UIWindow.keyboardWillHideNotification,
                                              object: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenterManager.removeObserver(observer: self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenterManager.removeObserver(observer: self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    func setupUI() {
        view.backgroundColor = Colors.mainColor()
        view.addTapRecognizer(target: self, action: #selector(endEnditing))
        navigationController?.isNavigationBarHidden = true
        
        view.addSubview(entryLabel)
        view.addSubview(tfStack)
        view.addSubview(forgotPaaswdButton)
        view.addSubview(howToEnterStack)
        
        entryLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(ENTRY_LABEL_HORIZONTAL_OFFSETS.scale())
            $0.width.equalTo(ENTRY_LABEL_WIDTH.scale())
            $0.height.equalTo(ENTRY_LABEL_HEIGHT.scale())
            topTobottomConstraintOfEntryLabel = $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(ENTRY_LABEL_TOP_OFFSET.scale()).constraint
        }
        
        tfStack.snp.makeConstraints {
            $0.left.equalToSuperview().offset(TF_STACK_HORIZONTAL_OFFSETS.scale())
            $0.right.equalToSuperview().inset(TF_STACK_HORIZONTAL_OFFSETS.scale())
            $0.top.equalTo(entryLabel.snp.bottom).offset(TF_STACK_TOP_OFFSET.scale())
        }
        
        forgotPaaswdButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(FORGOT_PASSWORD_BUTTON_HORIZONTAL_OFFSETS.scale())
            $0.right.equalToSuperview().inset(FORGOT_PASSWORD_BUTTON_HORIZONTAL_OFFSETS.scale())
            $0.top.equalTo(tfStack.snp.bottom).offset(FORGOT_PASSWORD_BUTTON_TOP_OFFSET.scale())
            $0.height.equalTo(FORGOT_PASSWORD_BUTTON_HEIGHT.scale())
        }
        
        howToEnterStack.snp.makeConstraints {
            $0.left.equalToSuperview().offset(HOW_TO_ENTER_STACK_HORIZONTAL_OFFSETS.scale())
            $0.right.equalToSuperview().inset(HOW_TO_ENTER_STACK_HORIZONTAL_OFFSETS.scale())
            topTobottomConstraintOfButton = $0.top.equalTo(forgotPaaswdButton.snp.bottom).offset(HOW_TO_ENTER_STACK_TOP_OFFSET.scale()).constraint
        }
    }
}

extension EnterViewController: EnterViewInput {
    
}

extension EnterViewController: HowToEnterStackViewDelegate {
    func enterButtonPressed() {
        output.enterButtonPressed()
    }
    
    func registerButtonPressed() {
        output.registerButtonPressed()
    }
    
    func noAccounButtonPressed() {
        output.noAccountButtonPressed()
    }
    
    @objc
    func fogotButtonPressed(_ sender: UIButton) {
        output.fogotPasswordButtonPressed()
    }
}
//MARK: - KeyBoardLogic
extension EnterViewController {
    @objc
    func keyboardWillShow(_ notification: Notification) {
        if topTobottomConstraintOfEntryLabel?.layoutConstraints[0].constant == ENTRY_LABEL_TOP_OFFSET.scale() {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.topTobottomConstraintOfEntryLabel?.layoutConstraints[0].constant -= FORGOT_PASSWORD_BUTTON_WIDTH.scale()
                self?.topTobottomConstraintOfButton?.layoutConstraints[0].constant -= ENTRY_LABEL_TOP_OFFSET.scale()
                self?.view.layoutIfNeeded()
            }
        }
    }
    @objc
    func keyboardWillHide(_ notification: Notification) {
        if topTobottomConstraintOfEntryLabel?.layoutConstraints[0].constant ?? 0 <= -70.scale() {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.topTobottomConstraintOfEntryLabel?.layoutConstraints[0].constant += FORGOT_PASSWORD_BUTTON_WIDTH.scale()
                self?.topTobottomConstraintOfButton?.layoutConstraints[0].constant += ENTRY_LABEL_TOP_OFFSET.scale()
                self?.view.layoutIfNeeded()
            }
        }
    }
    @objc
    func endEnditing() {
        view.endEditing(false)
    }
}
