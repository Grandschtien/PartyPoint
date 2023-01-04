//
//  FavouritesCollectionAdapter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 20.07.2022.
//

import UIKit


final class FavouritesCollectionAdapter: NSObject {
    typealias DataSource = UICollectionViewDiffableDataSource<Section<EventInfo>, EventInfo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section<EventInfo>, EventInfo>
    typealias Layout = UICollectionViewCompositionalLayout
    
    private var sections: [Section<EventInfo>]
    //Weak refereces
    private weak var collectionView: UICollectionView?
    
    weak var delegate: EventsDelegate?
    weak var scrollDelegate: EventsScrollDelegate?
    
    private lazy var dataSource: DataSource = setupDataSource()
    private lazy var collectionViewLayout: Layout = configureVerticalLayout()
    
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        sections = []
        super.init()
        collectionView.delegate = self
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
    /// This function must be envoked after initialize, because it configurates adapter
    /// - Parameter sections: Array of sections you want to have
    func configure(_ sections: [Section<EventInfo>]) {
        self.sections.append(contentsOf: sections)
        applySnapshot()
    }
    //MARK: - DataSource
    private func setupDataSource() -> DataSource {
        guard let collectionView = collectionView else {
            fatalError("No collection in adapter")
        }
        let dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, event) -> UICollectionViewCell in
            let cell = collectionView.dequeueCell(cellType: EventCell.self, for: indexPath)
            cell.configure(withEvent: event)
            return cell
        }
        return dataSource
    }
    private func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    /// This function setups vertical layout for collection view
    /// - Returns: Layout for vertical section
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
        delegate?.didTapOnEvent(sections[indexPath.section].items[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.collectionViewDidScroll(scrollView)
    }
    
}
