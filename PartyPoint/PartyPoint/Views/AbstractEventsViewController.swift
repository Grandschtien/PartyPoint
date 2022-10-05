//
//  AbstractEventsViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.07.2022.
//

import UIKit

///  Этот класс нужен, чтоб не повторять два одинаковых контроллера
class AbstractEventsViewController: UIViewController {
    
    internal lazy var navigationBar: NavigationBarWithLogo = {
        let nav = NavigationBarWithLogo(frame: .zero)
        
        return nav
    }()
    
    internal lazy var eventsCollection: UICollectionView = {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collection.registerWithNib(
            EventCell.self
        )
        collection.backgroundColor = Colors.mainColor()
        return collection
    }()
    
    /// Метод можно перегрузить, если надо зарегать хедер или какую ниубдь другую ячейку
    /// В нем уже прописан весь layout необходимый для того, что navigation bar вел себя так как нужно и т.д
    internal func setupUI() {
        view.backgroundColor = Colors.miniColor()
        let label = UILabel(frame: .zero)
        label.font = Fonts.sfProDisplaySemibold(size: 17)
        label.textColor = Colors.miniColor()
        label.text = Localizable.events_title()
        navigationItem.titleView = label
        
        //setup collection
        eventsCollection.showsVerticalScrollIndicator = false
        eventsCollection.showsHorizontalScrollIndicator = false
        view.addConstrained(subview: eventsCollection, top: nil, left: 0, bottom: 0, right: 0)
        eventsCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        eventsCollection.registerWithNib(
            EventCell.self
        )
        
        //This needs to set background for status bar
        changeStatusBarColor(Colors.mainColor())
        
        //setup navigation bar
        navigationController?.navigationBar.addConstrained(
            subview: navigationBar,
            top: nil,
            left: 0,
            bottom: nil,
            right: 0
        )
        navigationBar.topAnchor.constraint(
            equalTo:  navigationBar.topAnchor,
            constant: statusBarFrame.height
        ).isActive = true
        navigationBar.backgroundColor = Colors.mainColor()
        eventsCollection.contentInset.top = navigationBar.frame.height - statusBarFrame.height
        
    }
}

extension AbstractEventsViewController: EventsScrollDelegate {
    func collectionViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = eventsCollection.contentInset.top
        let offset = scrollView.contentOffset.y + contentOffset
        let alpha: CGFloat = 1 - (scrollView.contentOffset.y + contentOffset) / contentOffset
        navigationBar.alpha = alpha
        navigationItem.titleView?.alpha = -alpha
        navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
