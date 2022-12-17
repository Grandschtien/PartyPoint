//
//  EventsScrollDelegate.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 20.07.2022.
//

import UIKit
/// This delegate have to be implemented if you want to use delegates methods of scroll view
@objc
protocol EventsScrollDelegate: AnyObject {
    @objc func collectionViewDidScroll(_ scrollView: UIScrollView)
}
