//
//  AbstractEventsViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.07.2022.
//

import SnapKit
import UIKit
import PartyPointResources

private let TITLE_LABEL_FONT_SIZE: CGFloat = 16 * SCREEN_SCALE_BY_HEIGHT

///  Этот класс нужен, чтоб не повторять два одинаковых контроллера
open class AbstractEventsViewController: UIViewController {
    
    internal let navigationBar = PPProfileNavigationBar()
    private let connectionErrorView = PPConnectionErrorView()
    
    public  lazy var eventsCollection: UICollectionView = {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        
        collection.register(EventCell.self)
        
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = PartyPointResourcesAsset.mainColor.color
        return collection
    }()
    
    private var navigationTransform: CGAffineTransform?
    
    open func setupUI() {
        view.backgroundColor = PartyPointResourcesAsset.miniColor.color
        navigationBar.frame = .init(x: 0,
                                    y: 0,
                                    width: self.view.frame.width,
                                    height: navigationBar.height)
        navigationItem.titleView = navigationBar
        view.addSubview(eventsCollection)
        setupErrorConnectionView()
        setupConstraints()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.transform = navigationTransform ?? .identity
    }
    
    open func setupConstraints() {
        eventsCollection.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
    }
    
    open func setupNaviagtionBar(name: String?, avatar: String?) {
        navigationBar.configure(name: name, avatar: avatar)
    }
    
    open func setOpenProfileAction(_ action: @escaping (() -> Void)) {
        navigationBar.setOpenProfileAction(action)
    }
    
    open func setRefreshAction(_ action: @escaping (() -> Void)) {
        self.connectionErrorView.setRefreshAction(action)
    }
    
    open func setCollectionViewVisiabylity(isHidden: Bool) {
        eventsCollection.isHidden = isHidden
    }
    
    open func setupErrorConnectionView() {
        self.view.addSubview(connectionErrorView)
        connectionErrorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        connectionErrorView.isHidden = true
    }
    
    open func setErrorViewVisibility(isHidden: Bool) {
        connectionErrorView.isHidden = isHidden
    }
    
    open func setReasonToErrorView(reason: String) {
        connectionErrorView.updateView(withError: reason)
    }
}

extension AbstractEventsViewController: PPScrollDelegate {
    public func collectionViewDidScroll(_ scrollView: UIScrollView) {
        let safeAreaTop = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + safeAreaTop
        let alpha = 1 - ((scrollView.contentOffset.y + safeAreaTop) / safeAreaTop)
        navigationBar.alpha = alpha
        navigationTransform = .init(translationX: 0, y: min(0, -offset))
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
