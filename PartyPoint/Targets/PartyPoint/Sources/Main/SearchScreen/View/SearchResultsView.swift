//
//  SearchResultsView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.02.2023.
//  
//

import SnapKit
import UIKit
import PartyPointResources

private let ITEM_SIZE: CGSize = CGSize(width: 334.scale(), height: 194.scale())

final class SearchResultsView: UIView {
    typealias LoadNextPageAction = (Int) -> Void
    typealias TapOnEventsAction = (Int) -> Void
    typealias LikeAction = (Int) -> Void
    typealias UnlikeAction = (Int) -> Void
    
    private var likeAction: LikeAction?
    private var unlikeAction: UnlikeAction?
    
    // MARK: Private properties
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupCollectionViewLayout())
    private lazy var adapter = SearchAdapter(collectionView)
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        adapter.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: Private methods
private extension SearchResultsView {
    func setupUI() {
        self.backgroundColor = PartyPointResourcesAsset.mainColor.color
        
        setupCollectionView()
        self.addSubview(collectionView)
        
        setupConstraints()
    }
    
    func setupCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 10)
        layout.itemSize = ITEM_SIZE
        layout.minimumLineSpacing = 20
        
        return layout
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.keyboardDismissMode = .onDrag
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: Public methods
extension SearchResultsView {
    func setInitialContent(items: [EventInfo]) {
        adapter.setInitialContent(items: items)
    }
    
    func update(withItems items: [EventInfo]) {
        adapter.update(withItems: items)
    }
    
    func setOnButtonTapped(_ action: @escaping TapOnEventsAction) {
        adapter.setTapAction(action)
    }
    
    func setLoadNextPage(_ action: @escaping LoadNextPageAction) {
        adapter.setLoadNextPageAction(action)
    }
    
    func setLikeAction(_ action: @escaping LikeAction) {
        likeAction = action
    }
    
    func setUnlikeAction(_ action: @escaping LikeAction) {
        unlikeAction = action
    }
    
    func clearDataSource() {
        adapter.clearDataSource()
    }
}

// MARK: - SearchAdapterDelegate -
extension SearchResultsView: SearchAdapterDelegate {
    func eventLiked(index: Int) {
        likeAction?(index)
    }
    
    func setUnlikeEvent(index: Int) {
        unlikeAction?(index)
    }
}
