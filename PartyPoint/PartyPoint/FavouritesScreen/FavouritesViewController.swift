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
        adapter.delegate = self
        adapter.scrollDelegate = self
        return adapter
    }()
    private let output: FavouritesViewOutput

    init(output: FavouritesViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        favouritesCollectionAdapter.configure(Section<Event>.allSections)
    }
    
    internal override func setupUI() {
        super.setupUI()
    }
}

extension FavouritesViewController: FavouritesViewInput {
}

extension FavouritesViewController: EventsDelegate {
    func loadNetxtPage(page: Int) {
        
    }
    
    func didTapOnEvent(_ event: Event) {
        
    }
}
