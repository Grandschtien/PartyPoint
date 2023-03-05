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
    }
}

extension FavouritesViewController: FavouritesViewInput {
    func removeItem(atIndex index: Int) {
        favouritesCollectionAdapter.removeElemnt(atIndex: index)
    }
    
    func setLoaderIfNeeded(isLoading: Bool) {
        self.showLoaderIfNeeded(isLoading: isLoading)
    }
    
    func updateView(withInfo info: [EventInfo]) {
        favouritesCollectionAdapter.configure(info)
    }
    
    func showNothingLiked() {
        // to do
    }
    
    func showError(reason: String) {
        // to do
    }
    
    func showUserInfo(name: String, avatar: String?) {
        setupNaviagtionBar(name: name, avatar: avatar)
    }
}

extension FavouritesViewController: EventsDelegate {
    func loadNetxtPage(page: Int) {
        // do nothing 
    }
    
    func didTapOnEvent(_ event: EventInfo) {
        
    }
}
