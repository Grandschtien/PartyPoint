//
//  CityCell.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 09.05.2023.
//

import SnapKit
import UIKit
import PartyPointResources

private let CHECKBOX_SIZE: CGFloat = 25.scale()
private let CHECKBOX_RIGHT_INSET: CGFloat = 10
private let TITLE_LEFT_OFFSET: CGFloat = 10
private let TITLE_RIGHT_INSET: CGFloat = 10
private let TITLE_FONT_SIZE: CGFloat = 20.scale()

final class CityCell: UITableViewCell {
    private let checkbox = UIImageView()
    private let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(city: String, isSelected: Bool) {
        titleLabel.text = city
        checkbox.isHidden = !isSelected
    }
    
    func setSelected(isSelected: Bool) {
        checkbox.isHidden = !isSelected
    }
}

private extension CityCell {
    func setupUI() {
        self.backgroundColor = PartyPointResourcesAsset.mainColor.color
        self.selectionStyle = .none
        self.contentView.addSubview(checkbox)
        self.contentView.addSubview(titleLabel)
        setupConstraints()
        
        setupTitleLabel()
        setupCheckBox()
    }
    
    func setupConstraints() {
        checkbox.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CHECKBOX_SIZE)
            $0.right.equalToSuperview().inset(CHECKBOX_RIGHT_INSET)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(TITLE_LEFT_OFFSET)
            $0.right.equalTo(checkbox.snp.left).offset(TITLE_RIGHT_INSET)
        }
    }
    
    func setupCheckBox() {
        checkbox.image = PartyPointResourcesAsset.checkbox.image
    }
    
    func setupTitleLabel() {
        titleLabel.font = PartyPointResourcesFontFamily.SFProDisplay.medium.font(size: TITLE_FONT_SIZE)
    }
}
