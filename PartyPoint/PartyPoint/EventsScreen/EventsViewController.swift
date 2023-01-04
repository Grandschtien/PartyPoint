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
        navigationBar.isHidden = false
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
        eventsCollectionAdapter.setTapAction { section, item in
            
        }
        
        eventsCollectionAdapter.setLoadNextPageAction { page in
            
        }
    }
}

extension EventsViewController: EventsViewInput {
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

extension EventsViewController: EventsDelegate {
    func loadNetxtPage(page: Int) {
        
    }
    
    func didTapOnEvent(_ event: EventInfo) {
        let context = EventContext(moduleOutput: nil)
        let container = EventContainer.assemble(with: context)
        container.viewController.hidesBottomBarWhenPushed = true
        navigationBar.backgroundColor = .clear
        navigationBar.isHidden = true
        navigationController?.pushViewController(container.viewController, animated: true)
    }
}
