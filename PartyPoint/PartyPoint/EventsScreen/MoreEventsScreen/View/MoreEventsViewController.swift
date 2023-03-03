//
//  MoreEventsViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//  
//
import UIKit

final class MoreEventsViewController: UIViewController {
    
    // MARK: Private propeties
    private let presenter: MoreEventsPresenter
    private let contentView = MoreEventsContentView()
    
    // MARK: Init
    init(presenter: MoreEventsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupActions()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: Overriden methods
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.onViewDidLoad()
    }
}

// MARK: Private methods
private extension MoreEventsViewController {
    func setupActions() {
        contentView.setBackAction { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        contentView.setLoadNextPage { [weak self] page in
            self?.presenter.loadNextPage(page: page)
        }
        
        contentView.setOnButtonTapped { [weak self] index in
            self?.presenter.tappedOnEvent(index: index)
        }
        
        contentView.setLikeAction { [weak self] index in
            self?.presenter.likeEvent(index: index)
        }
        
        contentView.setUnlikeAction { [weak self] index in
            self?.presenter.unlikeEvent(index: index)
        }
    }
    
    func setupUI() {
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: MoreEventsView
extension MoreEventsViewController: MoreEventsView {
    func updateViewWithLike(isLiked: Bool, index: Int) {
        contentView.setLikeOnEvent(withIndex: index, isLiked: isLiked)
    }
    
    func showError(reason: String) {
        
    }
    
    func update(withEvents evetns: [EventInfo]) {
        contentView.updateView(withInfo: evetns)
    }
    
    func setLoaderVisiability(isLoading: Bool) {
        showLoaderIfNeeded(isLoading: isLoading)
    }
    
    func setTitle(_ title: String) {
        contentView.setTitle(title)
    }
    
    func openEvenScreen(eventId: Int, placeId: Int) {
        let eventContext = EventContext(eventId: eventId, placeId: placeId)
        let assembly = EventContainer.assemble(with: eventContext)
        self.navigationController?.pushViewController(assembly.viewController, animated: true)
    }
}
