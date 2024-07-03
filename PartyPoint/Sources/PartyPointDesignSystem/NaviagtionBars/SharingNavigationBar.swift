//
//  SharingNavigationBar.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 19.03.2023.
//

import SnapKit
private let BUTTONS_SIZE: CGFloat = 30.scale()
private let BACK_BUTTON_LEFT_OFFSET: CGFloat = 14
private let TITLE_FONT_SIZE: CGFloat = 16.scale()
private let NAV_BAR_HEIGHT: CGFloat = 42.scale()
private let TITLE_LABEL_HORIZONTAL_OFFSETS: CGFloat = 20

final class SharingNavigationBar: UIView {
    private var backAction: EmptyClosure?
    private var shareAction: EmptyClosure?

    private let sharingButton = UIButton()
    private let backButton = UIButton()
    private let titleLabel = PPScrollableLabel()
    private let horizontalStackView = UIStackView()
    
    var height: CGFloat {
        return NAV_BAR_HEIGHT
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setBackAction(_ action: @escaping EmptyClosure) {
        self.backAction = action
    }
    
    func setShareAction(_ action: @escaping EmptyClosure) {
        self.shareAction = action
    }
    
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
    
    func fontColor(color: UIColor?) {
        titleLabel.textColor = color
    }
}

private extension SharingNavigationBar {
    func setupUI() {
        self.addSubview(horizontalStackView)
        self.backgroundColor = .clear
        horizontalStackView.addArrangedSubview(backButton)
        horizontalStackView.addArrangedSubview(titleLabel)
        horizontalStackView.addArrangedSubview(sharingButton)
        
        setupBackButton()
        setupTitleLabel()
        setupSharingButton()
        
        setupConstraints()
    }
    
    func setupConstraints() {
        let titleWidth = UIScreen.main.bounds.width - TITLE_LABEL_HORIZONTAL_OFFSETS * 2 - BUTTONS_SIZE * 2
        horizontalStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(BACK_BUTTON_LEFT_OFFSET)
            $0.top.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.size.equalTo(BUTTONS_SIZE)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalTo(titleWidth)
        }
        
        sharingButton.snp.makeConstraints {
            $0.size.equalTo(BUTTONS_SIZE)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setupSharingButton() {
        sharingButton.setImage(R.image.shareOutline(), for: .normal)
        sharingButton.addTarget(self,
                                action: #selector(shareActionHandler),
                                for: .touchUpInside)

    }
    
    func setupBackButton() {
        backButton.setImage(R.image.chevronBack(), for: .normal)
        backButton.addTarget(self,
                             action: #selector(backActionHandler),
                             for: .touchUpInside)
    }
    
    func setupTitleLabel() {
        titleLabel.textColor = R.color.miniColor()
        titleLabel.font = R.font.sfProDisplaySemibold(size: TITLE_FONT_SIZE)
        titleLabel.textAlignment = .center
    }
    
    func setupHorizontalStackView() {
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = TITLE_LABEL_HORIZONTAL_OFFSETS
    }
}

private extension SharingNavigationBar {
    @objc
    func backActionHandler() {
        backAction?()
    }
    
    @objc
    func shareActionHandler() {
        shareAction?()
    }
}
