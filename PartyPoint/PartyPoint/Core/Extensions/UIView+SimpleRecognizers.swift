//
//  UIView+SimpleRecognizers.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 07.02.2023.
//

import UIKit

extension UIView {
    func addTapRecognizer(target: Any?, _ action: Selector?) {
        let tapRec = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tapRec)
    }
}
