//
//  NavigationBarWithLogoAndActions.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit

private let HORIZONTAL_OFFSET_OF_BUTTONS: CGFloat = 20
private let BUTTON_SIZE = 35.scale()

final class NavigationBarWithLogoAndActions: NavigationBarWithLogo {
    
    private var backAction: EmptyClosure?
    private var exitAction: EmptyClosure?
    private var shareAction: EmptyClosure?
    
    private let buttonsImges: Set<Buttons>
    private var buttons: [UIButton]
    private let isImageNeed: Bool
    private let isTitleNeeded: Bool
    
    init(background: UIColor = .clear,
         image: UIImage? = Images.logo(),
         frame: CGRect,
         buttons: Set<Buttons>,
         isImageNeed: Bool = true,
         isTitleNeeded: Bool = false
    ) {
        self.buttonsImges = buttons
        self.isImageNeed = isImageNeed
        self.buttons = []
        self.isTitleNeeded = isTitleNeeded
        super.init(background: background, image: image, frame: frame)
        configureActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum Buttons {
        case exit
        case back
        case share
    }
    
    func setTitle(_ text: String, isHidden: Bool) {
        title.text = text
        title.isHidden = isHidden
    }
    
    override func setupConstraintsForTitle() {
        title.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(HORIZONTAL_OFFSET_OF_BUTTONS + BUTTON_SIZE)
            $0.centerY.equalToSuperview()
        }
    }
}

extension NavigationBarWithLogoAndActions {
    func setBackAction(_ action: @escaping EmptyClosure) {
        self.backAction = action
    }
    
    func setExitAction(_ action: @escaping EmptyClosure) {
        self.exitAction = action
    }
    
    func setShareAction(_ action: @escaping EmptyClosure) {
        self.shareAction = action
    }
}

private extension NavigationBarWithLogoAndActions {
    func configureActions() {
        imageView.isHidden = !isImageNeed
        title.isHidden = !isTitleNeeded
        
        for buttonsImge in buttonsImges {
            let button = UIButton()
            buttons.append(button)
            
            button.backgroundColor = .clear
            self.addSubview(button)
            
            button.snp.makeConstraints { $0.size.equalTo(BUTTON_SIZE) }
            
            switch buttonsImge {
            case . exit:
                button.setImage(Images.exit(), for: .normal)
                button.snp.makeConstraints {
                    $0.right.equalToSuperview().inset(HORIZONTAL_OFFSET_OF_BUTTONS)
                    $0.centerY.equalToSuperview()
                }
                
                button.addTarget(self, action: #selector(exitActionTapped), for: .touchUpInside)
            case .back:
                button.setImage(Images.chevronBack(), for: .normal)
                button.snp.makeConstraints {
                    $0.left.equalToSuperview().offset(HORIZONTAL_OFFSET_OF_BUTTONS)
                    $0.centerY.equalToSuperview()
                }
                button.addTarget(self, action: #selector(backActionTapped), for: .touchUpInside)
            case .share:
                button.setImage(Images.shareOutline(), for: .normal)
                button.snp.makeConstraints {
                    $0.right.equalToSuperview().inset(HORIZONTAL_OFFSET_OF_BUTTONS)
                    $0.centerY.equalToSuperview()
                }
                button.addTarget(self, action: #selector(shareActionTapped), for: .touchUpInside)
            }
        }
    }
}

private extension NavigationBarWithLogoAndActions {
    @objc
    func backActionTapped(_ sender: UIButton) {
        backAction?()
    }
    
    @objc
    func exitActionTapped(_ sender: UIButton) {
        exitAction?()
    }
    
    @objc func shareActionTapped(_ sender: UIButton) {
        shareAction?()
    }
}
