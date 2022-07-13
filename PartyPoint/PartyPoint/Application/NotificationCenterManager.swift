//
//  NotificationCenterManager.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//

import Foundation


final class NotificationCenterManager {
  
    static func addObserver(observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }
    
    static func removeObserver(observer: Any,name: NSNotification.Name?, object: Any?) {
        NotificationCenter.default.removeObserver(observer, name: name, object: object)

    }
}
