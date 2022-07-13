//
//  NavigationBarWithLogoAndActions.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit
protocol NavigationBarWithLogoAndActionsDelegate: AnyObject {
    
}
final class NavigationBarWithLogoAndActions: NavigationBarWithLogo {
    
    private let buttons: [Buttons]
    
    init(background: UIColor = .clear,
         image: UIImage? = .logo,
         frame: CGRect,
         buttons: [Buttons]) {
        self.buttons = buttons
        super.init(background: background, image: image, frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        super.configure()
        
    }
    enum Buttons {
        case exit
        case back
    }
}
