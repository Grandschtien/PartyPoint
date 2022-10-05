//
//  AppButton.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit

final class AppButton: UIButton {
    var action: (() -> Void)?
    
    init(withTitle title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        self.titleLabel?.font = Fonts.sfProDisplaySemibold(size: 20)
        self.layer.cornerRadius = 8
        self.layer.backgroundColor = Colors.buttonColor()?.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0, options: []) {
            sender.alpha = 0.7
            sender.alpha = 1
        } completion: {[weak self] flag in
            self?.action?()
        }
    }
}
