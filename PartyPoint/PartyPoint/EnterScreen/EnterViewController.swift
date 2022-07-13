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
    
    private lazy var tfStack: UIStackView = {
        //TODO: Make localize list
        let placeholders: [String] = [
            EnterTfPlaceholders.email.rawValue,
            EnterTfPlaceholders.password.rawValue
        ]
        let stack = DynamicStackWithTF(frame: .zero, placeholders: placeholders)
        return stack
    }()
    
    private lazy var forgotPaaswdButton: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(LabelTexts.forgotPaaswdButton.rawValue, for: .normal)
        btn.titleLabel?.font = UIFont(name: UIFont.SFProDisplayBold, size: 14)
        btn.titleLabel?.textColor = .miniColor?.withAlphaComponent(0.75)
        btn.backgroundColor = .clear
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
    func setupUI() {
        view.backgroundColor = .mainColor
        navigationController?.isNavigationBarHidden = true
        view.addConstrained(subview: entryLabel,
                            top: nil,
                            left: 42,
                            bottom: nil,
                            right: nil)
        NSLayoutConstraint.activate([
            entryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            entryLabel.heightAnchor.constraint(equalToConstant: 108),
            entryLabel.widthAnchor.constraint(equalToConstant: 180)
        ])
        
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
        howToEnterStack.topAnchor.constraint (
            equalTo: forgotPaaswdButton.bottomAnchor,
            constant: 110
        ).isActive = true
        
    }
}

extension EnterViewController: EnterViewInput {
    
}

extension EnterViewController: HowToEnterStackViewDelegate {
    func enterButtonPressed() {
        print("Enter")
    }
    
    func registerButtonPressed() {
        print("register")
    }
    
    func noAccounButtonPressed() {
        print("no acc")
    }
    
    
}
