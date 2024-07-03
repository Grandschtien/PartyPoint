//
//  FavouriteScreenViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.04.2023.
//  
//
import UIKit

final class FavouriteScreenViewController: AbstractEventsViewController {
    
    // MARK: Private propeties
    private let presenter: FavouriteScreenPresenter
    
    private lazy var favouritesCollectionAdapter: FavouritesCollectionAdapter = {
        let adapter = FavouritesCollectionAdapter(eventsCollection)
        adapter.scrollDelegate = self
        adapter.delegate = self
        return adapter
    }()
    
    private let nothing_placeholder = FavouritesEmptyView()

    // MARK: Init
    init(presenter: FavouriteScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        presenter.onViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    internal override func setupUI() {
        super.setupUI()
        prepareForAppear()
    }
}

// MARK: Private methods
private extension FavouriteScreenViewController {
    func setupActions() {
        setOpenProfileAction { [weak self] in
            self?.presenter.getUserProfile()
        }
        
        favouritesCollectionAdapter.setTapOnEventAction { [weak self] index in
            self?.presenter.didTapOnEvent(withIndex: index)
        }
        
        favouritesCollectionAdapter.setLoadNextPageAction { [weak self] page in
            self?.presenter.loadNextPage(page: page)
        }
    }
    
    func prepareForAppear() {
        view.backgroundColor = R.color.mainColor()
        view.addSubview(nothing_placeholder)
        nothing_placeholder.isHidden = true
        nothing_placeholder.snp.makeConstraints {
            $0.left.top.right.bottom.equalToSuperview()
        }
    }
}

// MARK: Public methods
extension FavouriteScreenViewController {
    
}

// MARK: FavouriteScreenView
extension FavouriteScreenViewController: FavouriteScreenView {
    func updateWithNewEvent(eventInfo: EventInfo) {
        favouritesCollectionAdapter.appedElement(eventInfo)
        nothing_placeholder.isHidden = true
        setCollectionViewVisiabylity(isHidden: false)
        setErrorViewVisibility(isHidden: true)
    }
    
    func deleteEvent(eventInfo: EventInfo) {
        favouritesCollectionAdapter.removeElement(eventInfo)
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
    
    func validateAdatpter() {
        favouritesCollectionAdapter.removeAll()
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
    
    func updateWithNewPage(withInfo info: [EventInfo]) {
        favouritesCollectionAdapter.update(with: info)
    }
}

extension FavouriteScreenViewController: FavouritesCollectionAdapterDelegate {
    func eventDisliked(eventInfo: EventInfo) {
        presenter.eventDisliked(eventInfo: eventInfo)
    }
}
