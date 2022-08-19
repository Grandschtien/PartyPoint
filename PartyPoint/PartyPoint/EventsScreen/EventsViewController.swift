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
        adapter.delegate = self
        adapter.scrollDelegate = self
        return adapter
    }()
    
    private let output: EventsViewOutput
    
    init(output: EventsViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        eventsCollectionAdapter.configure(Section<Event>.allSections)
    }
    
    internal override func setupUI() {
        super.setupUI()
        eventsCollection.register(
            EventsTypeHeaderHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: EventsTypeHeaderHeader.reuseIdentifier
        )
    }
}

extension EventsViewController: EventsViewInput {
}

extension EventsViewController: EventsDelegate {
    func loadNetxtPage(page: Int) {
        
    }
    
    func didTapOnEvent(_ event: Event) {
        let context = EventContext(moduleOutput: nil)
        let container = EventContainer.assemble(with: context)
        navigationController?.pushViewController(container.viewController, animated: true)
    }
}
