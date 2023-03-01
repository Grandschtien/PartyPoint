//
//  EventsCollectionViewAdapter.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.07.2022.
//

import UIKit

protocol EventsCollectionViewAdapterDelegate: AnyObject {
    func eventLiked(eventId: Int, index: Int, section: SectionType)
    func eventDisliked(eventId: Int, index: Int, section: SectionType)
    func moreTapped(moreType: MoreEventsType)
}

final class EventsCollectionViewAdapter: NSObject {
    typealias DataSource = UICollectionViewDiffableDataSource<Section<EventInfo>, EventInfo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section<EventInfo>, EventInfo>
    typealias Layout = UICollectionViewCompositionalLayout
    typealias LoadNextPageAction = (Int) -> Void
    typealias TapOnEventsAction = (SectionType, Int) -> Void
    
    private var loadNextPageAction: LoadNextPageAction?
    private var didTapOnEventsAction: TapOnEventsAction?
    private var moreAction: EmptyClosure?
    
    private var sections: [Section<EventInfo>]
    private var currentPage = 1
    
    //Weak refereces
    private weak var collectionView: UICollectionView?
    
    weak var scrollDelegate: EventsScrollDelegate?
    weak var delegate: EventsCollectionViewAdapterDelegate?
    
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
    func configure(_ sections: [Section<EventInfo>]) {
        self.sections.append(contentsOf: sections)
        applySnapshot()
    }
    
    func addSection(_ section: Section<EventInfo>) {
        self.sections.append(section)
        applySnapshot()
    }
    
    func appendItemsIntoMainSection(info: [EventInfo]) {
        sections.mutateEach { section in
            if section.sectionType == .main {
                section.items.append(contentsOf: info)
            }
        }
        applySnapshot()
    }
    
    func updateLikeState(eventId: Int) {
        sections.mutateEach { section in
            section.items.mutateEach { event in
                if event.id == eventId { event.isLiked = !event.isLiked }
            }
        }
        applySnapshot()
    }
    
    func setTapAction(_ action: @escaping TapOnEventsAction) {
        self.didTapOnEventsAction = action
    }
    
    func setLoadNextPageAction(_ action: @escaping LoadNextPageAction) {
        self.loadNextPageAction = action
    }
}

//MARK: Private methods
private extension EventsCollectionViewAdapter {
    private func setupDataSource() -> DataSource {
        guard let collectionView = collectionView else {
            fatalError("No collection in adapter")
        }
        
        let dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, event) -> UICollectionViewCell in
            let cell = collectionView.dequeueCell(cellType: EventCell.self, for: indexPath)
            cell.configure(withEvent: event)
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            cell.setLikeAction { [weak self] in
                self?.delegate?.eventLiked(eventId: event.id,
                                           index: indexPath.item,
                                           section: section.sectionType)
            }
            
            cell.setDisLikeAction { [weak self] in
                self?.delegate?.eventDisliked(eventId: event.id,
                                              index: indexPath.item,
                                              section: section.sectionType)
            }
            
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
                if section.sectionType == .main {
                    header.configure(withHeader: unwrappedHeader, isMoreButtonHidden: true)
                } else {
                    header.configure(withHeader: unwrappedHeader, isMoreButtonHidden: false)
                    header.setMoreAction { [weak self] in
                        self?.delegate?.moreTapped(moreType: section.moreType)
                    }
                }
            }
            return header
        }
        return dataSource
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    private func setupLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] section, env in
            let section = self?.dataSource.snapshot().sectionIdentifiers[section]
            switch section?.sectionType {
            case .today:
                return self?.configureHorizontalLayoutSection()
            case .closest:
                return self?.configureHorizontalLayoutSection()
            case .main:
                return self?.configureVerticalLayoutSection()
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
        let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
        didTapOnEventsAction?(section.sectionType, indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if sections[indexPath.section].sectionType == .main {
            let currentSection = dataSource.snapshot().sectionIdentifiers[indexPath.section]
            if dataSource.snapshot().numberOfItems(inSection: currentSection) - 1 == indexPath.row {
                currentPage += 1
                loadNextPageAction?(currentPage)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.collectionViewDidScroll(scrollView)
    }
}
