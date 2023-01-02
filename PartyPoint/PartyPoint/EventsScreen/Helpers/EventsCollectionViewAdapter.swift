//
//  EventsCollectionViewAdapter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.07.2022.
//

import UIKit

final class EventsCollectionViewAdapter: NSObject {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section<Event>, Event>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section<Event>, Event>
    typealias Layout = UICollectionViewCompositionalLayout
    
    private var sections: [Section<Event>]
    //Weak refereces
    private weak var collectionView: UICollectionView?
    
    weak var delegate: EventsDelegate?
    weak var scrollDelegate: EventsScrollDelegate?
    
    private lazy var dataSource: DataSource = setupDataSource()
    private lazy var collectionViewLayout: Layout = setupLayout()
    
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        sections = []
        super.init()
        collectionView.delegate = self
        collectionView.collectionViewLayout = collectionViewLayout
    }
    
    /// This function must be envoked after initialize, because it configurates adapter
    /// - Parameter sections: Array of sections you want to have
    func configure(_ sections: [Section<Event>]) {
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
        dataSource.supplementaryViewProvider = { [weak self]
            (
             collectionView: UICollectionView,
             kind: String,
             indexPath: IndexPath
            )
            -> UICollectionReusableView? in
            guard let `self` = self else  {
                return nil
            }
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }
            let section = self.dataSource.snapshot()
              .sectionIdentifiers[indexPath.section]
            let header = collectionView.dequeueSupplementary(
                ofType: EventsTypeHeaderHeader.self,
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: EventsTypeHeaderHeader.reuseIdentifier,
                for: indexPath)
            if let unwrappedHeader = section.header {
                header.configure(withHeader: unwrappedHeader)
            }
            return header
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
    private func setupLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] section, env in
            switch section {
            case 0:
                return self?.configureHorizontalLayoutSection()
            case 1:
                return self?.configureHorizontalLayoutSection()
            default:
                return self?.configureVerticalLayoutSection()
            }
        }
        return layout
    }
    /// This function setups horizontal layout for collection view
    /// - Returns: Layout for horizontal section
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
    
    /// This function setups vertical layout for collection view
    /// - Returns: Layout for vertical section
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
        
        group.contentInsets.leading = 10
        group.contentInsets.trailing = 10
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [setupHeader()]
        section.contentInsets.leading = 10
        section.contentInsets.trailing = 10
        section.contentInsets.top = 10
        
        return section
    }
    
    /// This function setups header layout for collection view
    /// - Returns: Layout for section header
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

// MARK: - UICollectionViewDelegate
extension EventsCollectionViewAdapter: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        //TODO: - Make it more correctly
        delegate?.didTapOnEvent(sections[indexPath.section].items[indexPath.item])
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.collectionViewDidScroll(scrollView)
    }
}
