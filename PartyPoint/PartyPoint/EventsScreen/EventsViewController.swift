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
        navigationBar.backgroundColor = Colors.mainColor()
    }
    
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = Colors.mainColor()
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
    }
}

extension EventsViewController: EventsViewInput {
    func setInitialUserInfo(name: String?, image: String?) {
        setupNaviagtionBar(name: name, avatar: image)
    }
    
    func showNewPageInMainSection(with info: [EventInfo]) {
        eventsCollectionAdapter.appendItemsIntoMainSection(info: info)
    }
    
    func updateTodaySection(with section: Section<EventInfo>) {
        eventsCollectionAdapter.addSection(section)
    }
    
    func updateClosestSection(with section: Section<EventInfo>) {
        eventsCollectionAdapter.addSection(section)
    }
    
    func updateMainSection(with section: Section<EventInfo>) {
        eventsCollectionAdapter.addSection(section)
    }
    
    func updateView(withError reason: String) {
        //TODO: implement error
        debugPrint(reason)
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
}

extension EventsViewController: EventsCollectionViewAdapterDelegate {
    func moreTapped(moreType: MoreEventsType) {
        output.moreTapped(moreType: moreType)
    }
    
    func eventLiked(eventId: Int, index: Int, section: Int) {
        output.eventLiked(eventId: eventId, index: index, section: section)
    }
}
