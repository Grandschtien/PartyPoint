//
//  HowToEnterStackView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//

import UIKit
import PartyPointResources

private let ENTER_BUTTON_HEIGHT: CGFloat = 56 * SCREEN_SCALE_BY_HEIGHT

public protocol HowToEnterStackViewDelegate: AnyObject {
    func enterButtonPressed()
    func registerButtonPressed()
    func noAccounButtonPressed()
}

public final class HowToEnterStackView: UIStackView {
    
    public weak var delegate: HowToEnterStackViewDelegate?
    
    private let labelsFont = PartyPointResourcesFontFamily.SFProDisplay.bold.font(size: 15)
    
    private lazy var enterButton: PPButton = {
        let btn = PPButton(style: .primary, size: .l)
        btn.setTitle(PartyPointResourcesStrings.Localizable.enterButtonTitle, for: .normal)
        btn.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    private(set) lazy var registerLabel: UILabel = {
        let label = UILabel()
        label.font = labelsFont
        label.textAlignment = .center
        let text = NSMutableAttributedString(string: PartyPointResourcesStrings.Localizable.registerLabel)
        let currLocAndLen = getCurrLocationAndLenth(str: PartyPointResourcesStrings.Localizable.registerLabel)
        text.addAttributes(
            [.foregroundColor: PartyPointResourcesAsset.buttonColor.color],
            range: NSRange(location: currLocAndLen.location, length: currLocAndLen.length)
        )
        label.attributedText = text
        label.addTapRecognizer(target: self, action: #selector(registerButtonPressed(_:)))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setLoadingVisible() {
        enterButton.isLoading = true
    }
    
    public func setLoadingHide() {
        enterButton.isLoading = false
    }
    
    private func setupUI() {
        self.addArrangedSubview(enterButton)
        self.addArrangedSubview(registerLabel)
        
        enterButton.snp.makeConstraints {
            $0.height.equalTo(ENTER_BUTTON_HEIGHT)
            $0.left.right.equalToSuperview()
        }
        
        registerLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
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
    @objc
    func enterButtonPressed() {
        enterButton.isLoading = true
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
