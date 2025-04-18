//
//  SearchAdapter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 19.03.2023.
//

import UIKit
import PartyPointDesignSystem

protocol SearchAdapterDelegate: AnyObject {
    func eventLiked(index: Int)
    func setUnlikeEvent(index: Int)
}

final class SearchAdapter: NSObject {
    enum Section {
        case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, EventInfo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, EventInfo>
    typealias LoadNextPageAction = (Int) -> Void
    typealias TapOnEventsAction = (Int) -> Void
    
    private var loadNextPageAction: LoadNextPageAction?
    private var didTapOnEventsAction: TapOnEventsAction?
    
    private var items: [EventInfo]
    private var currentPage = 1
    
    private weak var collectionView: UICollectionView?
    
    weak var delegate: SearchAdapterDelegate?
    
    private lazy var dataSource: DataSource = setupDataSource()
    
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        items = []
        super.init()
        collectionView.delegate = self
        collectionView.register(EventCell.self)
    }
    
    func setInitialContent(items: [EventInfo]) {
        self.items = items
        applySnapshot()
    }
    
    func update(withItems items: [EventInfo]) {
        self.items.append(contentsOf: items)
        applySnapshot()
    }
    
    func clearDataSource() {
        items = []
        applySnapshot()
    }
    
    func updateEventWithLike(isLiked: Bool, index: Int) {
        self.items[index].isLiked = isLiked
    }
    
    func setTapAction(_ action: @escaping TapOnEventsAction) {
        self.didTapOnEventsAction = action
    }
    
    func setLoadNextPageAction(_ action: @escaping LoadNextPageAction) {
        self.loadNextPageAction = action
    }
}

//MARK: Private methods
private extension SearchAdapter {
    private func setupDataSource() -> DataSource {
        guard let collectionView = collectionView else {
            fatalError("No collection in adapter")
        }
        
        let dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, event) -> UICollectionViewCell in
            let cell = collectionView.dequeueCell(cellType: EventCell.self, for: indexPath)
            cell.configure(withEvent: event)
            
            cell.setLikeAction { [weak self] in
                self?.delegate?.eventLiked(index: indexPath.item)
            }
            
            cell.setDisLikeAction { [weak self] in
                self?.delegate?.setUnlikeEvent(index: indexPath.item)
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
}

// MARK: - UICollectionViewDelegate
extension SearchAdapter: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        didTapOnEventsAction?(indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if dataSource.snapshot().numberOfSections - 1 == indexPath.section {
            let currentSection = dataSource.snapshot().sectionIdentifiers[indexPath.section]
            if dataSource.snapshot().numberOfItems(inSection: currentSection) - 1 == indexPath.row {
                currentPage += 1
                loadNextPageAction?(currentPage)
            }
        }
    }
}
