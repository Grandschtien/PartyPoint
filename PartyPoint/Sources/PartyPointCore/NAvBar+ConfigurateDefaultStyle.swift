//
//  NAvBar+ConfigurateDefaultStyle.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 30.08.2022.
//

import UIKit

extension UIViewController {
    func configurateNavBarWithButtons(
        buttons: (left: NavigationBarWithLogoAndActions.Buttons?, right: NavigationBarWithLogoAndActions.Buttons?),
        actions: (leftAction: Selector?, rightAction: Selector?))
    {
        var rightBarButton: UIBarButtonItem?
        var leftBarButton: UIBarButtonItem?
        
        if let leftButton = buttons.left {
            switch leftButton {
            case .exit:
                leftBarButton = UIBarButtonItem(image:  PartyPointAsset.exit.image, style: .plain, target: self, action: actions.leftAction)
            case .share:
                leftBarButton = UIBarButtonItem(image: PartyPointAsset.shareOutline.image, style: .plain, target: self, action: actions.leftAction)
            case .back:
                leftBarButton = UIBarButtonItem(image: PartyPointAsset.chevronBack.image, style: .plain, target: self, action: actions.leftAction)
            }
        }
        
        if let rightButton = buttons.right {
            switch rightButton {
            case .exit:
                rightBarButton = UIBarButtonItem(image: PartyPointAsset.exit.image, style: .plain, target: self, action: actions.rightAction)
            case .share:
                rightBarButton = UIBarButtonItem(image: PartyPointAsset.shareOutline.image, style: .plain, target: self, action: actions.rightAction)
            case .back:
                rightBarButton = UIBarButtonItem(image: PartyPointAsset.chevronBack.image, style: .plain, target: self, action: actions.rightAction)
            }
        }
        
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
}
