//
//  NavigationBarWithLogoAndActions.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit
@objc
protocol NavigationBarWithLogoAndActionsDelegate: AnyObject {
    @objc optional func backAction()
    @objc optional func exitAction()
}
final class NavigationBarWithLogoAndActions: NavigationBarWithLogo {
    
    private let buttonsImges: Set<Buttons>
    private var buttons: [UIButton]
    private let isImageNeed: Bool
    weak var delegate: NavigationBarWithLogoAndActionsDelegate?
    init(background: UIColor = .clear,
         image: UIImage? = .logo,
         frame: CGRect,
         buttons: Set<Buttons>,
         isImageNeed: Bool = true) {
        self.buttonsImges = buttons
        self.isImageNeed = isImageNeed
        self.buttons = []
        super.init(background: background, image: image, frame: frame)
        configureActions()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    enum Buttons {
        case exit
        case back
    }
    
    func configureActions() {
        imageView.isHidden = !isImageNeed
        for buttonsImge in buttonsImges {
            let button = UIButton()
            buttons.append(button)
            button.backgroundColor = .clear
            button.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(button)
            button.heightAnchor.constraint(equalToConstant: 35).isActive = true
            button.widthAnchor.constraint(equalToConstant: 35).isActive = true
            switch buttonsImge {
            case . exit:
                button.setImage(.exit, for: .normal)
                button.rightAnchor.constraint(
                    equalTo: self.rightAnchor,
                    constant: -20).isActive = true
                button.centerYAnchor.constraint(
                    equalTo: self.centerYAnchor
                ).isActive = true
                button.addTarget(self, action: #selector(exitActionTapped), for: .touchUpInside)
            case .back:
                button.setImage(.chevronBack, for: .normal)
                button.leftAnchor.constraint(
                    equalTo: self.leftAnchor,
                    constant: 20).isActive = true
                button.centerYAnchor.constraint(
                    equalTo: self.centerYAnchor
                ).isActive = true
                button.addTarget(self, action: #selector(backActionTapped), for: .touchUpInside)
            }
        }
    }
    
    @objc
    func backActionTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.alpha = 0.75
            sender.alpha = 1.0
        } completion: { [weak self] _ in
            self?.delegate?.backAction?()
        }

    }
    
    @objc
    func exitActionTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.alpha = 0.75
            sender.alpha = 1.0
        } completion: { [weak self] _ in
            self?.delegate?.exitAction?()
        }

    }
    
}
