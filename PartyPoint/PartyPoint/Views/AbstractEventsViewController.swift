//
//  AbstractEventsViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.07.2022.
//

import UIKit

private let TITLE_LABEL_FONT_SIZE: CGFloat = 17 * SCREEN_SCALE_BY_HEIGHT

///  Этот класс нужен, чтоб не повторять два одинаковых контроллера
class AbstractEventsViewController: UIViewController {
    
    internal let navigationBar =  NavigationBarWithLogo(frame: .zero)
    internal lazy var eventsCollection: UICollectionView = {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        
        collection.register(EventCell.self)
        
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        
        collection.backgroundColor = Colors.mainColor()
        return collection
    }()
    
    internal lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Fonts.sfProDisplaySemibold(size: TITLE_LABEL_FONT_SIZE)
        label.textColor = Colors.miniColor()
        label.text = Localizable.events_title()
        label.backgroundColor = Colors.mainColor()
        return label
    }()
    
    /// Метод можно перегрузить, если надо зарегать хедер или какую ниубдь другую ячейку
    /// В нем уже прописан весь layout необходимый для того, что navigation bar вел себя так как нужно и т.д
    internal func setupUI() {
        view.backgroundColor = Colors.miniColor()
        navigationController?.navigationBar.backgroundColor = Colors.mainColor()
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.backgroundColor = Colors.mainColor()
        navigationItem.titleView?.backgroundColor = Colors.mainColor()
        navigationBar.backgroundColor = Colors.mainColor()
        view.addSubview(eventsCollection)
        navigationController?.navigationBar.addSubview(navigationBar)
        
        setupConstraints()
                
        eventsCollection.contentInset.top = (navigationBar.height - statusBarFrame.height) * SCREEN_SCALE_BY_HEIGHT
    }
    
    func setupConstraints() {
        eventsCollection.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        navigationBar.snp.makeConstraints {
            $0.right.left.equalToSuperview()
            $0.top.equalTo(navigationBar.snp.top).offset(statusBarFrame.height)
        }
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
