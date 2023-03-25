//
//  FavouritesViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit

final class FavouritesViewController: AbstractEventsViewController {
    private lazy var favouritesCollectionAdapter: FavouritesCollectionAdapter = {
        let adapter = FavouritesCollectionAdapter(eventsCollection)
        adapter.scrollDelegate = self
        return adapter
    }()
    
    private let output: FavouritesViewOutput
    private let nothing_placeholder = FavouritesEmptyView()

    init(output: FavouritesViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        output.onViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    internal override func setupUI() {
        super.setupUI()
        view.backgroundColor = Colors.mainColor()
        view.addSubview(nothing_placeholder)
        nothing_placeholder.isHidden = true
        nothing_placeholder.snp.makeConstraints {
            $0.left.top.right.bottom.equalToSuperview()
        }
    }
}

private extension FavouritesViewController {
    func setupActions() {
        setOpenProfileAction { [weak self] in
            self?.output.getUserProfile()
        }
        
        favouritesCollectionAdapter.setTapOnEventAction { [weak self] index in
            self?.output.tapOnEvent(index: index)
        }
        
        setRefreshAction { [weak self] in
            self?.output.tryToRefresh()
        }
    }
}

extension FavouritesViewController: FavouritesViewInput {
    func removeItem(atIndex index: Int) {
        favouritesCollectionAdapter.removeElemnt(atIndex: index)
    }
    
    func setLoaderIfNeeded(isLoading: Bool) {
        self.showLoaderIfNeeded(isLoading: isLoading)
    }
    
    func isNoConnectionViewNeeded(isHidden: Bool) {
        setErrorViewVisibility(isHidden: isHidden)
    }
    
    func updateView(withInfo info: [EventInfo]) {
        nothing_placeholder.isHidden = true
        setCollectionViewVisiabylity(isHidden: false)
        setErrorViewVisibility(isHidden: true)
        favouritesCollectionAdapter.configure(info)
    }
    
    func showNothingLiked() {
        setLoaderIfNeeded(isLoading: false)
        setCollectionViewVisiabylity(isHidden: true)
        nothing_placeholder.isHidden = false
    }
    
    func showError(reason: String) {
        setReasonToErrorView(reason: reason)
        setLoaderIfNeeded(isLoading: false)
        nothing_placeholder.isHidden = true
        setErrorViewVisibility(isHidden: false)
        setCollectionViewVisiabylity(isHidden: true)
    }
    
    func showUserInfo(name: String, avatar: String?) {
        setupNaviagtionBar(name: name, avatar: avatar)
    }
}
