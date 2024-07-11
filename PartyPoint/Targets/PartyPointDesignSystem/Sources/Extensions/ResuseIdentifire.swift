//
//  ResuseIdentifire.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import Foundation
import UIKit

public protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
    public static var nibName: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}

extension UITableViewHeaderFooterView: ReuseIdentifiable {}

extension UICollectionReusableView: ReuseIdentifiable {}

extension UITableView {
    public func dequeue<T: UITableViewCell>(cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Can't deque")
        }
        return cell
    }
    
    public func registerNib<T: UITableViewCell>(cellType: T.Type) {
        self.register(UINib(nibName: T.nibName, bundle: nil), forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    public func registerCell<T: UITableViewCell> (cellType: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    public func dequeueSupplementaryView<T: UITableViewHeaderFooterView>(ofType type: T.Type) -> T {
        guard let headerOrFooter = self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("cannot dequeue header")
        }
        return headerOrFooter
    }
}

extension UICollectionView {
    public func dequeueCell<T: UICollectionViewCell>(cellType: T.Type,
                                              for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier,
                                                  for: indexPath) as? T
        else {
            fatalError("Can't deque")
        }
        return cell
    }
    
    public func dequeueSupplementary<T: UICollectionReusableView>(
        ofType type: T.Type,
        ofKind kind: String,
        withReuseIdentifier identifier: String,
        for indexPath: IndexPath
    ) -> T {
        guard let view = self.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: type.reuseIdentifier,
            for: indexPath) as? T else {
            fatalError("Can't deque")
        }
        return view
    }
    
    public func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        self.register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    public func registerFooter<T: UICollectionReusableView>(_ view: T.Type) {
        self.register(view,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: view.reuseIdentifier)
    }
    
    public func registerWithNib<T: UICollectionViewCell>(_ cellType: T.Type) {
        self.register(
            UINib(nibName: cellType.nibName, bundle: nil),
            forCellWithReuseIdentifier: cellType.reuseIdentifier
        )
    }
}
