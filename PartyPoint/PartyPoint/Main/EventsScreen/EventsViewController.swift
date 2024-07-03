//
//  EventsViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit

final class EventsViewController: AbstractEventsViewController {
    private lazy var eventsCollectionAdapter: EventsCollectionViewAdapter = {
        let adapter = EventsCollectionViewAdapter(eventsCollection)
        adapter.scrollDelegate = self
        adapter.delegate = self
        return adapter
    }()
    
    private let output: EventsViewOutput
    
    init(output: EventsViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        setupActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        output.onViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = R.color.mainColor()
        eventsCollection.register(
            EventsTypeHeaderHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: EventsTypeHeaderHeader.reuseIdentifier
        )
    }
}

private extension EventsViewController {
    func setupActions() {
        eventsCollectionAdapter.setTapAction { [weak self] section, item in
            self?.output.tappedOnEvents(section: section, index: item)
        }
        
        eventsCollectionAdapter.setLoadNextPageAction { [weak self] page in
            self?.output.loadNextPage(page)
        }
        
        setOpenProfileAction {
            self.output.openProfile()
        }
        
        setRefreshAction { [weak self] in
            self?.output.tryToReloadData()
        }
    }
}

extension EventsViewController: EventsViewInput {
    func updateViewWithNewLike(eventId: Int) {
        eventsCollectionAdapter.updateLikeState(eventId: eventId)
    }
    
    func setInitialUserInfo(name: String?, image: String?) {
        setupNaviagtionBar(name: name, avatar: image)
    }
    
    func showNewPageInMainSection(with info: [EventInfo]) {
        eventsCollectionAdapter.appendItemsIntoMainSection(info: info)
    }
    
    func updateTodaySection(with section: Section<EventInfo>) {
        setErrorViewVisibility(isHidden: true)
        setCollectionViewVisiabylity(isHidden: false)
        eventsCollectionAdapter.addSection(section)
    }
    
    func updateClosestSection(with section: Section<EventInfo>) {
        eventsCollectionAdapter.addSection(section)
    }
    
    func updateMainSection(with section: Section<EventInfo>) {
        eventsCollectionAdapter.addSection(section)
    }
    
    func updateView(withError reason: String) {
        setReasonToErrorView(reason: reason)
    }
    
    func showErrorViewIfNeeded(isHidden: Bool) {
        setErrorViewVisibility(isHidden: isHidden)
    }
    
    func changeCollectionViewVisibility(isHidden: Bool) {
        eventsCollection.isHidden = isHidden
    }
    
    func showLoaderView() {
        self.showLoader()
    }
    
    func hideLoaderView() {
        self.hideLoader()
    }
    
    func clearAdapter() {
        eventsCollectionAdapter.clear()
    }
}

extension EventsViewController: EventsCollectionViewAdapterDelegate {
    func eventLiked(index: Int, section: SectionType) {
        output.eventLiked(index: index, section: section)
    }
    
    func eventDisliked(index: Int, section: SectionType) {
        output.eventDisliked(index: index, section: section)
    }
    
    func moreTapped(moreType: MoreEventsType) {
        output.moreTapped(moreType: moreType)
    }
}
