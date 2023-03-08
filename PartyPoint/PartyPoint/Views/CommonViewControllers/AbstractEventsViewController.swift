//
//  AbstractEventsViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.07.2022.
//

import SnapKit

private let TITLE_LABEL_FONT_SIZE: CGFloat = 16 * SCREEN_SCALE_BY_HEIGHT

///  Этот класс нужен, чтоб не повторять два одинаковых контроллера
class AbstractEventsViewController: UIViewController {
    
    internal let navigationBar = PPProfileNavigationBar()
    private let connectionErrorView = PPConnectionErrorView()
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
    
    internal func setupUI() {
        view.backgroundColor = Colors.miniColor()
        navigationBar.frame = .init(x: 0,
                                    y: 0,
                                    width: self.view.frame.width,
                                    height: navigationBar.height)
        navigationItem.titleView = navigationBar
        view.addSubview(eventsCollection)
        setupErrorConnectionView()
        setupConstraints()
    }
    
    func setupConstraints() {
        eventsCollection.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
    }
    
    func setupNaviagtionBar(name: String?, avatar: String?) {
        navigationBar.configure(name: name, avatar: avatar)
    }
    
    func setOpenProfileAction(_ action: @escaping EmptyClosure) {
        navigationBar.setOpenProfileAction(action)
    }
    
    func setCollectionViewVisiabylity(isHidden: Bool) {
        eventsCollection.isHidden = isHidden
    }
    
    func setupErrorConnectionView() {
        self.view.addSubview(connectionErrorView)
        connectionErrorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        connectionErrorView.isHidden = true
    }
    
    func setErrorViewVisibility(isHidden: Bool) {
        connectionErrorView.isHidden = isHidden
    }
}

extension AbstractEventsViewController: EventsScrollDelegate {
    func collectionViewDidScroll(_ scrollView: UIScrollView) {
        let safeAreaTop = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + safeAreaTop
        let alpha = 1 - ((scrollView.contentOffset.y + safeAreaTop) / safeAreaTop)
        navigationBar.alpha = alpha
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
