//
//  LocationView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 22.08.2022.
//

import UIKit

private let LABEL_FONTS_SIZE: CGFloat = 15.scale()

final class LocationView: UIView {
    private let labelsFont = R.font.sfProDisplayBold(size: LABEL_FONTS_SIZE)
    
    private let locationLabel = UILabel()
    private let dateLabel = UILabel()
    private let timeLabel = UILabel()
    
    private let horizontalStack = UIStackView()
    private let verticalStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configure(with info: LocationInfo) {
        locationLabel.set(text: info.address, leftIcon: R.image.location(), rightIcon: nil)
        dateLabel.set(text: info.date, leftIcon: R.image.calendar(), rightIcon: nil)
        if !info.time.isEmpty {
            timeLabel.set(text: info.time, leftIcon: R.image.time(), rightIcon: nil)
        }
    }
}

private extension LocationView {
    func setupUI() {
        dateLabel.font = labelsFont
        locationLabel.font = labelsFont
        timeLabel.font = labelsFont
        dateLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        locationLabel.numberOfLines = 0
        
        dateLabel.textColor = R.color.miniColor()
        locationLabel.textColor = R.color.miniColor()
        timeLabel.textColor = R.color.miniColor()
        
        horizontalStack.addArrangedSubview(dateLabel)
        horizontalStack.addArrangedSubview(timeLabel)
        
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 6.scale()
        
        verticalStack.addArrangedSubview(locationLabel)
        verticalStack.addArrangedSubview(horizontalStack)
        
        verticalStack.axis = .vertical
        verticalStack.spacing = 6.scale()
        addSubview(verticalStack)
        
        verticalStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
