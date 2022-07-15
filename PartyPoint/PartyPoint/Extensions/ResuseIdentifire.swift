//
//  ResuseIdentifire.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import Foundation
import UIKit

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    static var nibName: String {
        return String(describing: self)
    }
}


extension UICollectionReusableView: ReuseIdentifiable {}

extension UICollectionView {
    func dequeueCell<T: UICollectionViewCell>(cellType: T.Type,
                                              for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier,
                                                  for: indexPath) as? T
        else {
            fatalError("Can't deque")
        }
        return cell
    }
    func dequeueSupplementary<T: UICollectionReusableView>(
        ofType type: T.Type,
        ofKind kind: String,
        withReuseIdentifier identifier: String,
        for indexPath: IndexPath
    ) -> T {
        guard let view = self.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: identifier,
            for: indexPath) as? T else {
            fatalError("Can't deque")
        }
        return view
    }
    
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        self.register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    func registerWithNib<T: UICollectionViewCell>(_ cellType: T.Type) {
        self.register(
            UINib(nibName: cellType.nibName, bundle: nil),
            forCellWithReuseIdentifier: cellType.reuseIdentifier
        )
    }
    
}
