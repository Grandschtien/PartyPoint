//
//  FavouritesCollectionAdapter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 20.07.2022.
//

import UIKit

protocol FavouritesCollectionAdapterDelegate: AnyObject {
    func eventDisliked(eventInfo: EventInfo)
}

final class FavouritesCollectionAdapter: NSObject {
    typealias TapOnEventsAction = (Int) -> Void
    
    enum FavoriteSection {
        case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<FavoriteSection, EventInfo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<FavoriteSection, EventInfo>
    typealias Layout = UICollectionViewCompositionalLayout
    
    private var items: [EventInfo]

    private weak var collectionView: UICollectionView?
    
    weak var scrollDelegate: EventsScrollDelegate?
    weak var delegate: FavouritesCollectionAdapterDelegate?
    
    private var didTapOnEventsAction: TapOnEventsAction?
    
    private lazy var dataSource: DataSource = setupDataSource()
    private lazy var collectionViewLayout: Layout = configureVerticalLayout()
    
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        items = []
        super.init()
        collectionView.delegate = self
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
    func configure(_ items: [EventInfo]) {
        self.items = items
        applySnapshot()
    }
    
    func removeElemnt(atIndex index: Int) {
        self.items.remove(at: index)
        applySnapshot()
    }
    
    func removeAll() {
        self.items = []
        applySnapshot()
    }
    
    func removeElement(_ element: EventInfo) {
        self.items.removeAll { $0.id == element.id }
        applySnapshot()
    }
    
    func appedElement(_ element: EventInfo) {
        self.items.insert(element, at: 0)
        applySnapshot()
    }
    
    func setTapOnEventAction(_ action: @escaping TapOnEventsAction) {
        self.didTapOnEventsAction = action
    }
    
    //MARK: - DataSource
    private func setupDataSource() -> DataSource {
        guard let collectionView = collectionView else {
            fatalError("No collection in adapter")
        }
        
        let dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, event) -> UICollectionViewCell in
            let cell = collectionView.dequeueCell(cellType: EventCell.self, for: indexPath)
            let item = self.items[indexPath.item]
            cell.configure(withEvent: event)
            
            cell.setDisLikeAction { [weak self] in
                self?.delegate?.eventDisliked(eventInfo: item)
            }
            
            return cell
        }
        return dataSource
    }
    
    private func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureVerticalLayout() -> UICollectionViewCompositionalLayout {
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
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 20
        section.contentInsets.trailing = 20
        section.contentInsets.top = 10
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension FavouritesCollectionAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTapOnEventsAction?(indexPath.item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.collectionViewDidScroll(scrollView)
    }
}
