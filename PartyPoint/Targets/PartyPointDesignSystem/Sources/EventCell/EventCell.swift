//
//  EventCell.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 15.07.2022.
//

import SnapKit
import UIKit
import PartyPointResources

private let DESTIONATION_FONT: CGFloat = 15.scale()
private let NAME_FONT: CGFloat = 30.scale()
private let DATE_FONT: CGFloat = 20.scale()
private let VERTICAL_STACK_VIEW_SPACING: CGFloat = 2.scale()
private let VERTICAL_STACK_VIEW_LEFT_OFFSET: CGFloat = 20
private let VERTICAL_STACK_VIEW_BOTTOM_OFFSET: CGFloat = 20
private let LIKE_VIEW_SIZE: CGFloat = 40.scale()
private let LIKE_VIEW_TOP_OFFSET: CGFloat = 10
private let LIKE_VIEW_RIGHT_OFFSET: CGFloat = 10

public final class EventCell: UICollectionViewCell {
    private let imageView = AcyncImageView(placeHolderType: .event)
    private let nameLabel = PPScrollableLabel()
    private let dateLabel = UILabel()
    private let likeView = PPLikeView()
    private let verticalStackView = UIStackView()
    
    //MARK: Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    //MARK: Override
    public override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    //MARK: Public
    public func configure(withEvent event: EventCellContent) {
        self.nameLabel.text = event.title
        self.dateLabel.text = event.date
        self.imageView.setImage(url: event.image)
        self.likeView.changeLikeState(isLiked: event.isLiked)
    }
    
    public func setLikeAction(_ action: @escaping (() -> Void)) {
        likeView.setLikeAction(action)
    }
    
    public func setDisLikeAction(_ action: @escaping (() -> Void)) {
        likeView.setDislikeAction(action)
    }
}

//MARK: Private methods
private extension EventCell {
    func addSubviews() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(likeView)
        self.bringSubviewToFront(likeView)
        self.imageView.addSubview(verticalStackView)
        self.verticalStackView.addArrangedSubview(nameLabel)
        self.verticalStackView.addArrangedSubview(dateLabel)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        verticalStackView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(VERTICAL_STACK_VIEW_LEFT_OFFSET)
            $0.right.equalToSuperview().inset(VERTICAL_STACK_VIEW_LEFT_OFFSET)
            $0.bottom.equalToSuperview().inset(VERTICAL_STACK_VIEW_BOTTOM_OFFSET)
        }
        
        [nameLabel, dateLabel].forEach { label in
            label.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
        
        likeView.snp.makeConstraints {
            $0.right.equalToSuperview().inset(LIKE_VIEW_TOP_OFFSET)
            $0.top.equalToSuperview().offset(LIKE_VIEW_TOP_OFFSET)
            $0.size.equalTo(LIKE_VIEW_SIZE)
        }
    }
    
    func setupUI() {
        addSubviews()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        verticalStackView.spacing = VERTICAL_STACK_VIEW_SPACING
        nameLabel.font = PartyPointResourcesFontFamily.SFProDisplay.bold.font(size: NAME_FONT)
        nameLabel.textColor = PartyPointResourcesAsset.miniColor.color
        
        dateLabel.font = PartyPointResourcesFontFamily.SFProDisplay.semibold.font(size: DATE_FONT)
        dateLabel.textColor = PartyPointResourcesAsset.miniColor.color
        
        imageView.contentMode = .scaleAspectFill
        
        setupConstraints()
    }
}
