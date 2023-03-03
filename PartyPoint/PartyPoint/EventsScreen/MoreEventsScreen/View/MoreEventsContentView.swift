//
//  MoreEventsContentView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 25.02.2023.
//  
//

import SnapKit

private let ITEM_SIZE: CGSize = CGSize(width: 334.scale(), height: 194.scale())

final class MoreEventsContentView: UIView {
    typealias LoadNextPageAction = (Int) -> Void
    typealias TapOnEventsAction = (Int) -> Void
    typealias LikeAction = (Int) -> Void
    typealias UnlikeAction = (Int) -> Void
    
    // MARK: Private properties
    private let navigationBar = PlainNavigationBar()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private lazy var adapter = MoreEventsAdapter(collectionView)
    
    private var likeAction: LikeAction?
    private var unlikeAction: UnlikeAction?
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: Private methods
private extension MoreEventsContentView {
    func setupUI() {
        adapter.delegate = self
        self.backgroundColor = Colors.mainColor()
        self.addSubview(navigationBar)
        self.addSubview(collectionView)
        
        setupCollectionView()
        
        setupConstraints()
    }
    
    func setupConstraints() {
        navigationBar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(navigationBar.height)
            $0.top.equalToSuperview().offset(statusBarFrame.height)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 10)
        layout.itemSize = ITEM_SIZE
        layout.minimumLineSpacing = 20
        collectionView.collectionViewLayout = layout
    }
}

// MARK: Public methods
extension MoreEventsContentView {
    func setTitle(_ title: String) {
        navigationBar.setTitle(title)
    }
    
    func updateView(withInfo info: [EventInfo]) {
        adapter.update(withItems: info)
    }
    
    func setBackAction(_ action: @escaping EmptyClosure) {
        navigationBar.setBackAction(action)
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
    
    func setLikeOnEvent(withIndex index: Int, isLiked: Bool) {
        adapter.updateEventWithLike(isLiked: isLiked, index: index)
    }
}

// MARK: - MoreEventsAdapterDelegate -
extension MoreEventsContentView: MoreEventsAdapterDelegate {
    func eventLiked(index: Int) {
        likeAction?(index)
    }
    
    func setUnlikeEvent(index: Int) {
        unlikeAction?(index)
    }
}

