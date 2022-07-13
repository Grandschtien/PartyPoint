//
//  HowToEnterStackView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//

import UIKit

protocol HowToEnterStackViewDelegate: AnyObject {
    func enterButtonPressed()
    func registerButtonPressed()
    func noAccounButtonPressed()
}

class HowToEnterStackView: UIStackView {
    
    weak var delegate: HowToEnterStackViewDelegate?
    
    private let labelsFont = UIFont(name: UIFont.SFProDisplayBold, size: 15)
    
    private lazy var enterButton: AppButton = {
        let btn = AppButton(withTitle: LabelTexts.enterButton.rawValue)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.action = { [weak self] in
            self?.enterButtonPressed()
        }
        return btn
    }()
    private(set) lazy var registerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = labelsFont
        label.textAlignment = .center
        let text = NSMutableAttributedString(string: LabelTexts.registerLabel.rawValue)
        let currLocAndLen = getCurrLocationAndLenth(str:LabelTexts.registerLabel.rawValue)
        text.addAttributes(
            [.foregroundColor: UIColor.buttonColor!],
            range: NSRange(location: currLocAndLen.location, length: currLocAndLen.length)
        )
        label.attributedText = text
        label.addTapRecognizer(target: self, action: #selector(registerButtonPressed(_:)))
        label.isUserInteractionEnabled = true
        return label
    }()
    private lazy var orLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = labelsFont
        label.textColor = .miniColor
        label.text = LabelTexts.orLabel.rawValue
        label.textAlignment = .center
        return label
    }()
    private(set) lazy var withoutAccLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = labelsFont
        label.textColor = .buttonColor
        label.text = LabelTexts.withoutAccLabel.rawValue
        label.textAlignment = .center
        label.addTapRecognizer(target: self, action: #selector(enterWithOutAccount(_:)))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addArrangedSubview(enterButton)
        self.addArrangedSubview(registerLabel)
        self.addArrangedSubview(orLabel)
        self.addArrangedSubview(withoutAccLabel)
        
        NSLayoutConstraint.activate([
            enterButton.heightAnchor.constraint(equalToConstant: 56),
            enterButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            enterButton.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            registerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            registerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            orLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            orLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            withoutAccLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            withoutAccLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.axis = .vertical
        self.spacing = 10
        self.alignment = .center
    }
    
    private func getCurrLocationAndLenth(str: String) -> (location: Int, length: Int) {
        let arr = Array(str)
        guard let firstQuest = arr.lastIndex(of: " ") else {
            return (0, 0)
        }
        let firstPart = arr[0...firstQuest]
        let secondPart = arr[firstQuest + 1...arr.count - 1]
        
        return (firstPart.count, secondPart.count)
    }
}

//MARK: Actions
extension HowToEnterStackView {
    func enterButtonPressed() {
        delegate?.enterButtonPressed()
    }
    @objc
    func registerButtonPressed(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.2, delay: 0, options: []) {
            sender.view?.alpha = 0.75
            sender.view?.alpha = 1.0
        } completion: { [weak self] _ in
            self?.delegate?.registerButtonPressed()
        }

    }
    @objc
    func enterWithOutAccount(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.2, delay: 0, options: []) {
            sender.view?.alpha = 0.75
            sender.view?.alpha = 1.0
        } completion: { [weak self] _ in
            self?.delegate?.noAccounButtonPressed()
        }
    }
}
