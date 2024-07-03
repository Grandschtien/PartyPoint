//
//  DescriptionEventView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 23.08.2022.
//

import SnapKit

private let DESCRIPTION_FONT_SIZE: CGFloat = 15.scale()

final class DescriptionEventView: DefaultEventView {
    private let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    override var titleText: String {
        return R.string.localizable.description()
    }
    
    override func setupUI() {
        self.addSubview(descriptionLabel)
        super.setupUI()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = R.font.sfProDisplaySemibold(size: DESCRIPTION_FONT_SIZE)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func configure(withDescription descr: String) {
        self.descriptionLabel.text = descr
    }
}

