//
//  EventRouter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 16.08.2022.
//  
//

import UIKit
import PartyPointNavigation
import PartyPointResources

final class EventRouter: BaseRouter {}

extension EventRouter: EventRouterInput {
    func backToPrevController() {
        pop(animated: true)
    }
    
    func openSuperviserSite(with url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func openShareSheeet(with url: URL) {
        let items = [url]
        let actionSheet = UIActivityViewController(activityItems: items, applicationActivities: nil)
        actionSheet.excludedActivityTypes = [.copyToPasteboard]
        actionSheet.view.backgroundColor = PartyPointResourcesAsset.mainColor.color
        present(vc: actionSheet, animated: true)
    }
}
