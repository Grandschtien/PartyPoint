//
//  DefaultSearchView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 18.03.2023.
//

import SnapKit
import UIKit
import Lottie

private let TITLE_LABEL_FONT_SIZE: CGFloat = 16.scale()
private let SUBTITLE_LABEL_FONT_SIZE: CGFloat = 14.scale()
private let STACK_VIEW_SPACING: CGFloat = 5
private let ICON_SIZE: CGFloat = 100.scale()
private let STACK_VIEW_HORIZONTAL_INSETS: CGFloat = 73
 
class DefaultSearchView: UIView {
    private lazy var searchIcon = LottieAnimationView(name: animationName)
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let verticalStackView = UIStackView()
    
    var animationName: String {
        return Animations.search.rawValue
    }
    
    var numberOfRowsInTitle: Int {
        return 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(with config: SearchViewConfiguration) {
        titleLabel.text = config.title
        subtitleLabel.text = config.subtitle
    }
    
    func startAnimation() {
        searchIcon.play()
    }
}

// MARK: Private methods
private extension DefaultSearchView {
    func setupUI() {
        self.backgroundColor = PartyPointAsset.mainColor.color
        
        self.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(searchIcon)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleLabel)
        
        setupVerticalStackView()
        setupSearchIcon()
        setupTitleLabel()
        setupSubtitle()
        setupConstraints()
    }
    
    func setupConstraints() {
        verticalStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(STACK_VIEW_HORIZONTAL_INSETS)
        }
        
        searchIcon.snp.makeConstraints {
            $0.size.equalTo(ICON_SIZE)
        }
        
        [titleLabel, subtitleLabel].forEach { label in
            label.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
        }
    }
    
    func setupVerticalStackView() {
        verticalStackView.axis = .vertical
        verticalStackView.spacing = STACK_VIEW_SPACING
        verticalStackView.alignment = .center
    }
    
    func setupSearchIcon() {
        searchIcon.contentMode = .scaleAspectFill
        searchIcon.animationSpeed = 1
        searchIcon.backgroundColor = PartyPointAsset.mainColor.color
        searchIcon.loopMode = .loop
    }
    
    func setupTitleLabel() {
        titleLabel.font = PartyPointFontFamily.SFProDisplay.bold.font(size: TITLE_LABEL_FONT_SIZE)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = numberOfRowsInTitle
    }
    
    func setupSubtitle() {
        subtitleLabel.font = PartyPointFontFamily.SFProDisplay.regular.font(size: SUBTITLE_LABEL_FONT_SIZE)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 2
    }
}


