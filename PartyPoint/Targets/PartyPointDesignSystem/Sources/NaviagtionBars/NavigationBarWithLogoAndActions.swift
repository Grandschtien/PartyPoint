//
//  NavigationBarWithLogoAndActions.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit
import PartyPointResources

private let HORIZONTAL_OFFSET_OF_BUTTONS: CGFloat = 20
private let BUTTON_SIZE = 35.scale()

public final class NavigationBarWithLogoAndActions: NavigationBarWithLogo {
    
    private var backAction: (() -> Void)?
    private var exitAction: (() -> Void)?
    private var shareAction: (() -> Void)?
    
    private let buttonsImges: Set<Buttons>
    private var buttons: [UIButton]
    private let isImageNeed: Bool
    private let isTitleNeeded: Bool
    
    public init(background: UIColor = .clear,
         image: UIImage? = PartyPointResourcesAsset.logo.image,
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
        return nil
    }
    
    public enum Buttons {
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
    public func setBackAction(_ action: @escaping (() -> Void)) {
        self.backAction = action
    }
    
    public func setExitAction(_ action: @escaping (() -> Void)) {
        self.exitAction = action
    }
    
    public func setShareAction(_ action: @escaping (() -> Void)) {
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
                button.setImage(PartyPointResourcesAsset.exit.image, for: .normal)
                button.snp.makeConstraints {
                    $0.right.equalToSuperview().inset(HORIZONTAL_OFFSET_OF_BUTTONS)
                    $0.centerY.equalToSuperview()
                }
                
                button.addTarget(self, action: #selector(exitActionTapped), for: .touchUpInside)
            case .back:
                button.setImage(PartyPointResourcesAsset.chevronBack.image, for: .normal)
                button.snp.makeConstraints {
                    $0.left.equalToSuperview().offset(HORIZONTAL_OFFSET_OF_BUTTONS)
                    $0.centerY.equalToSuperview()
                }
                button.addTarget(self, action: #selector(backActionTapped), for: .touchUpInside)
            case .share:
                button.setImage(PartyPointResourcesAsset.shareOutline.image, for: .normal)
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
