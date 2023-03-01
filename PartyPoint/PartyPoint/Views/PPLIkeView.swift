//
//  PPLIkeView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 04.01.2023.
//

import SnapKit

private let LIKE_VIEW_CORNER_RADIUS: CGFloat = 10.scale()
private let LIKE_VIEW_OFFSET: CGFloat = 5

final class PPLikeView: UIView {
    private var likeAction: EmptyClosure?
    private var dislikeAction: EmptyClosure?
    
    private let likeImage = UIImageView()
    
    private var isLiked: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
}

//MARK: Public methods
extension PPLikeView {
    func changeLikeState(isLiked: Bool) {
        likeImage.image = isLiked ? Images.heartFill() : Images.heartOutline()
        self.isLiked = isLiked
    }
    
    func setLikeAction(_ action: @escaping EmptyClosure) {
        self.likeAction = action
    }
    
    func setDislikeAction(_ action: @escaping EmptyClosure) {
        self.dislikeAction = action
    }
}

//MARK: Private methods
extension PPLikeView {
    func setupUI() {
        self.addSubview(likeImage)
        
        self.likeImage.image = Images.heartOutline()
        self.layer.cornerRadius = LIKE_VIEW_CORNER_RADIUS
        self.backgroundColor = Colors.miniColor()
        self.layer.opacity = 0.6
        self.clipsToBounds = true
        self.layer.allowsGroupOpacity = false
        self.addTapRecognizer(target: self, #selector(likeActionHandler))
        
        setupConstraints()
    }
    
    func setupConstraints() {
        likeImage.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(LIKE_VIEW_OFFSET)
        }
    }
}

// MARK: - Action hadlers -
extension PPLikeView {
    @objc
    func likeActionHandler() {
        isLiked ? dislikeAction?() : likeAction?()
        changeLikeState(isLiked: !isLiked)
    }
}
