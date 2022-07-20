//
//  EventsViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import UIKit

final class EventsViewController: UIViewController {
    
    private lazy var navigationBar: NavigationBarWithLogo = {
        let nav = NavigationBarWithLogo(frame: .zero)
        
        return nav
    }()
    
    private lazy var eventsCollection: UICollectionView = {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collection.registerWithNib(
            EventCell.self
        )
        collection.register(
            CollectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CollectionHeader.reuseIdentifier
        )
        collection.backgroundColor = .mainColor
        return collection
    }()
    
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
        eventsCollectionAdapter.configure(Section.allSections)
    }
    
    private func setupUI() {
        view.backgroundColor = .mainColor
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: UIFont.SFProDisplaySemibold, size: 17)
        label.textColor = .miniColor
        label.text = LabelTexts.events.rawValue
        navigationItem.titleView = label
        
        //setup collection
        eventsCollection.showsVerticalScrollIndicator = false
        eventsCollection.showsHorizontalScrollIndicator = false
        view.addConstrained(subview: eventsCollection, top: nil, left: 0, bottom: 0, right: 0)
        eventsCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        //This needs to set background for status bar
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        guard let statusBarFrame = window?.windowScene?.statusBarManager?.statusBarFrame else {
            return
        }
        let statusBarView = UIView(frame: statusBarFrame)
        self.view.addSubview(statusBarView)
        statusBarView.backgroundColor = .mainColor
        
        //setup navigation bar
        view.addConstrained(subview: navigationBar, top: nil, left: 0, bottom: nil, right: 0)
        navigationBar.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor
        ).isActive = true
        navigationBar.backgroundColor = .mainColor
        eventsCollection.contentInset.top = navigationBar.frame.height
        
    }
}

extension EventsViewController: EventsViewInput {
}

extension EventsViewController: EventsDelegate {
    func loadNetxtPage(page: Int) {
        
    }
    
    func didTapOnEvent(_ event: Event) {
        
    }
}

extension EventsViewController: EventsScrollDelegate {
    func collectionViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = navigationBar.frame.height
        let offset = scrollView.contentOffset.y + contentOffset
        let alpha: CGFloat = 1 - (scrollView.contentOffset.y + contentOffset) / contentOffset
        navigationBar.alpha = alpha
        navigationItem.titleView?.alpha = -alpha
        navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
