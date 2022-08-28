//
//  LocationView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 22.08.2022.
//

import UIKit

final class LocationView: UIView {
    
    private let labelsFont = UIFont(name: UIFont.SFProDisplayBold, size: 15)
    
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
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateWithLocationDateAndTime(_ location: String, _ date: String, _ time: String) {
        locationLabel.set(text: location, leftIcon: .location, rightIcon: nil)
        dateLabel.set(text: date, leftIcon: .calendar, rightIcon: nil)
        timeLabel.set(text: time, leftIcon: .time, rightIcon: nil)
    }
}


private extension LocationView {
    func setupUI() {
        dateLabel.font = labelsFont
        locationLabel.font = labelsFont
        timeLabel.font = labelsFont
        dateLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        dateLabel.textColor = .miniColor
        locationLabel.textColor = .miniColor
        timeLabel.textColor = .miniColor
        
        horizontalStack.addArrangedSubview(dateLabel)
        horizontalStack.addArrangedSubview(timeLabel)
        
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 6.scale()
        
        verticalStack.addArrangedSubview(locationLabel)
        verticalStack.addArrangedSubview(horizontalStack)
        
        verticalStack.axis = .vertical
        verticalStack.spacing = 4.scale()
        addSubview(verticalStack)
        
        verticalStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
