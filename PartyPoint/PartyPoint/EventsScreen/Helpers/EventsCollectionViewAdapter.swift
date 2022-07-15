//
//  EventsCollectionViewAdapter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.07.2022.
//

import UIKit

protocol EventsAdapterDelegate: AnyObject {
    func loadNetxtPage(page: Int)
    func didTapOnEvent(_ event: Event)
}

protocol EventsAdapterScrollDelegate: AnyObject {
    func collectionDidScrollVertical(_ scrollView: UIScrollView,
                                     withVelocity velocity: CGPoint)
}

final class EventsCollectionViewAdapter: NSObject {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Event>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Event>
    private var sections: [Section]
    //Weak refereces
    private weak var collectionView: UICollectionView?
    
    weak var delegate: EventsAdapterDelegate?
    weak var scrollDelegate: EventsAdapterScrollDelegate?
    
    private lazy var dataSource: DataSource = setupDataSource()
    
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        sections = []
        super.init()
        collectionView.delegate = self
    }
    
    func configure(_ sections: [Section]) {
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
                ofType: CollectionHeader.self,
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: CollectionHeader.reuseIdentifier,
                for: indexPath)
            header.configure(withHeader: section.header)
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
}

// MARK: - UICollectionViewDelegate
extension EventsCollectionViewAdapter: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {}
    
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        scrollDelegate?.collectionDidScrollVertical(scrollView, withVelocity: velocity)
    }
    
}
