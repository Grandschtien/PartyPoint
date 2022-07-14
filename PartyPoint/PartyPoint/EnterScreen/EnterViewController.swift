//
//  EnterViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit

final class EnterViewController: UIViewController {
    
    private lazy var entryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: UIFont.SFProDisplaySemibold, size: 30)
        label.numberOfLines = 3
        label.text = LabelTexts.entryLabel.rawValue
        return label
    }()
    
    private lazy var tfStack: DynamicStackWithTF = {
        //TODO: Make localize list
        let placeholders: [String] = [
            LabelTexts.email.rawValue,
            LabelTexts.password.rawValue
        ]
        let stack = DynamicStackWithTF(frame: .zero, placeholders: placeholders)
        return stack
    }()
    private var topTobottomConstraintOfEntryLabel: NSLayoutConstraint?
    private var topTobottomConstraintOfButton: NSLayoutConstraint?
    
    private lazy var forgotPaaswdButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(LabelTexts.forgotPaaswdButton.rawValue, for: .normal)
        btn.titleLabel?.font = UIFont(name: UIFont.SFProDisplayBold, size: 14)
        btn.titleLabel?.textColor = .miniColor?.withAlphaComponent(0.75)
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
        view.backgroundColor = .mainColor
        view.addTapRecognizer(target: self, action: #selector(endEnditing))
        navigationController?.isNavigationBarHidden = true
        view.addConstrained(subview: entryLabel,
                            top: nil,
                            left: 42,
                            bottom: nil,
                            right: nil)
        NSLayoutConstraint.activate([
            entryLabel.heightAnchor.constraint(equalToConstant: 108),
            entryLabel.widthAnchor.constraint(equalToConstant: 180)
        ])
        topTobottomConstraintOfEntryLabel = entryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        topTobottomConstraintOfEntryLabel?.isActive = true

        
        view.addConstrained(subview: tfStack,
                            top: nil,
                            left: 15,
                            bottom: nil,
                            right: -15)
        tfStack.topAnchor.constraint(
            equalTo: entryLabel.bottomAnchor,
            constant: 35
        ).isActive = true
        view.addSubview(forgotPaaswdButton)
        NSLayoutConstraint.activate([
            forgotPaaswdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgotPaaswdButton.widthAnchor.constraint(equalToConstant: 120),
            forgotPaaswdButton.topAnchor.constraint(equalTo: tfStack.bottomAnchor,
                                                    constant: 25),
            forgotPaaswdButton.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        view.addConstrained(subview: howToEnterStack,
                            top: nil,
                            left: 30,
                            bottom: nil,
                            right: -30)
        topTobottomConstraintOfButton = howToEnterStack.topAnchor.constraint (
            equalTo: forgotPaaswdButton.bottomAnchor,
            constant: 110
        )
        topTobottomConstraintOfButton?.isActive = true
        
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
        if topTobottomConstraintOfEntryLabel?.constant == 50 {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.topTobottomConstraintOfEntryLabel?.constant -= 120
                self?.topTobottomConstraintOfButton?.constant -= 50
                self?.view.layoutIfNeeded()
            }
        }
    }
    @objc
    func keyboardWillHide(_ notification: Notification) {
        if topTobottomConstraintOfEntryLabel?.constant == -70 {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.topTobottomConstraintOfEntryLabel?.constant += 120
                self?.topTobottomConstraintOfButton?.constant += 50
                self?.view.layoutIfNeeded()
            }
        }
    }
    @objc
    func endEnditing() {
        view.endEditing(false)
    }
}
