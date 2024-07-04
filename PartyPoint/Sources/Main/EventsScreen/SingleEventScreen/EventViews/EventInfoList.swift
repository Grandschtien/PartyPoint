//
//  EventInfoList.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 19.08.2022.
//

import SnapKit
import UIKit

private let VERTICAL_OFFSET = 12.scale()
private let HORISONTAL_OFFSET = 15.scale()
private let HEADER_OFFSET = 10.scale()
private let MAP_HEIGHT: CGFloat = 200.scale()

final class EventInfoView: UIView {
    
    private let header = EventHeaderLabel(frame: .zero, labelType: .main)
    private let locationView = LocationView()
    private let descriptionView = DescriptionEventView()
    private let costView = EventViewWithButton()
    private let mapView = EventMapView()
    
    private var fullHeight: CGFloat?
    
    var height: CGFloat {
        return fullHeight ?? 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fullHeight = countHeight()
    }
    
    func configure(withInfo info: EventFullInfo) {
        header.text = info.title
        locationView.configure(with: info.location)
        mapView.configure(with: info.placeAnnotation)
        descriptionView.configure(withDescription: info.description)
        costView.configure(forCost: info.cost)
    }
    
    func setOpenSuperviserSite(_ action: @escaping EmptyClosure) {
        self.costView.setOpenSuperviserSiteAction(action)
    }
}

private extension EventInfoView {
    func setupUI() {
        self.addSubview(header)
        
        header.snp.makeConstraints {
            $0.top.equalToSuperview().offset(HEADER_OFFSET)
            $0.leading.equalToSuperview().offset(HORISONTAL_OFFSET)
            $0.trailing.equalToSuperview().inset(HORISONTAL_OFFSET)
        }
        
        addSubview(locationView)
        locationView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(VERTICAL_OFFSET)
            $0.leading.equalToSuperview().offset(HORISONTAL_OFFSET)
            $0.trailing.equalToSuperview().inset(HORISONTAL_OFFSET)
        }
        
        addSubview(descriptionView)
        descriptionView.snp.makeConstraints {
            $0.top.equalTo(locationView.snp.bottom).offset(VERTICAL_OFFSET)
            $0.leading.equalToSuperview().offset(HORISONTAL_OFFSET)
            $0.trailing.equalToSuperview().inset(HORISONTAL_OFFSET)
        }

        addSubview(costView)
        costView.snp.makeConstraints {
            $0.top.equalTo(descriptionView.snp.bottom).offset(VERTICAL_OFFSET)
            $0.leading.equalToSuperview().offset(HORISONTAL_OFFSET)
            $0.trailing.equalToSuperview().inset(HORISONTAL_OFFSET)
        }
        
        addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.top.equalTo(costView.snp.bottom).offset(VERTICAL_OFFSET)
            $0.leading.equalToSuperview().offset(HORISONTAL_OFFSET)
            $0.trailing.equalToSuperview().inset(HORISONTAL_OFFSET)
            $0.height.equalTo(MAP_HEIGHT)
        }
    }
    
    func countHeight() -> CGFloat {
        let height = VERTICAL_OFFSET * 5 + HEADER_OFFSET + header.frame.size.height + locationView.frame.size.height + descriptionView.frame.size.height + costView.frame.size.height + mapView.frame.size.height
        return height
    }
}
