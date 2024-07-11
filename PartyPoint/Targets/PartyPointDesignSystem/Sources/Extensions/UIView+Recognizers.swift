//
//  UILabel+Recognizers.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//

import Foundation
import UIKit

extension UIView {
    public func addTapRecognizer(target: Any?, action: Selector?) {
        let tapRec = UITapGestureRecognizer(target: target, action: action)
        tapRec.numberOfTapsRequired = 1
        tapRec.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapRec)
    }
}
