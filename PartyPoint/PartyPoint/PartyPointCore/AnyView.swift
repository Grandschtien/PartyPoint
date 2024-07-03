//
//  AnyView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 28.08.2022.
//

import UIKit

protocol AnyView {
    var view: UIView { get }
}

extension AnyView where Self: UIView {
    var view: UIView {
        return self
    }
}

extension UIView: AnyView {}
