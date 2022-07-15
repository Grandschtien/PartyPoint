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
        let collection = UICollectionView(frame: .zero, collectionViewLayout: setupLayout())
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
        return adapter
    }()
    private var collectionTopAnchor: NSLayoutConstraint?
    private var navigationBarTopAnchor: NSLayoutConstraint?
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
        view.clipsToBounds = true
        navigationController?.isNavigationBarHidden = true
        eventsCollection.showsVerticalScrollIndicator = false
        eventsCollection.showsHorizontalScrollIndicator = false
        view.addConstrained(subview: navigationBar, top: nil, left: 0, bottom: nil, right: 0)
        navigationBarTopAnchor = navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        navigationBarTopAnchor?.isActive = true
        navigationBar.heightAnchor.constraint(equalToConstant: 78).isActive = true
        view.addConstrained(subview: eventsCollection, top: nil, left: 0, bottom: 0, right: 0)
        collectionTopAnchor = eventsCollection.topAnchor.constraint(equalTo: navigationBar.bottomAnchor)
        collectionTopAnchor?.isActive = true
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        guard let statusBarFrame = window?.windowScene?.statusBarManager?.statusBarFrame else {
            return
        }
        let statusBarView = UIView(frame: statusBarFrame)
        self.view.addSubview(statusBarView)
        statusBarView.backgroundColor = .mainColor
    }
    
    private func setupLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {[weak self] section, env in
            switch section {
            case 2:
                return self?.configureVerticalLayoutSection()
            default:
                return self?.configureHorizontalLayoutSection()
            }
        }
        return layout
    }
    
    private func configureHorizontalLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.edgeSpacing = .init(leading: .fixed(10), top: .fixed(10), trailing: .fixed(10), bottom: nil)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [setupHeader()]
        section.contentInsets.trailing = 10
        section.contentInsets.leading = 10
        section.contentInsets.bottom = 10
        return section
    }
    private func configureVerticalLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.top = 5
        item.contentInsets.bottom = 15
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(250))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.edgeSpacing = .init(leading: nil, top: .fixed(10), trailing: nil, bottom: nil)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [setupHeader()]
        section.contentInsets.leading = 20
        section.contentInsets.trailing = 20
        return section
    }
    
    private func setupHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerItemSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        return header
    }
}

extension EventsViewController: EventsViewInput {
}

extension EventsViewController: EventsAdapterDelegate {
    
    func loadNetxtPage(page: Int) {
        
    }
    
    func didTapOnEvent(_ event: Event) {
        
    }
    func collectionDidScrollVertical(_ scrollView: UIScrollView, withVelocity velocity: CGPoint) {
        if(velocity.y>0) {
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {[weak self] in
                guard let `self` = self,
                      let constant = self.navigationBarTopAnchor?.constant
                else { return }
                if constant >= 0 {
                    self.navigationBarTopAnchor?.constant = -150
                    self.view.layoutIfNeeded()
                }
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {[weak self] in
                guard let `self` = self, let constant = self.navigationBarTopAnchor?.constant  else { return }
                if constant < 0 {
                    self.navigationBarTopAnchor?.constant += 150
                    self.view.layoutIfNeeded()
                }
            }, completion: nil)
        }
    }
}
