//
//  EventMapView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 23.08.2022.
//

import SnapKit
import UIKit
import MapKit

private let ROOT_VIEW_CORNER_RADIUS: CGFloat = 20
private let MAP_TOP_OFFSET: CGFloat = 8

final class EventMapView: DefaultEventView {
    // MARK: Private properties
    private let map = MKMapView()
    
    // MARK: Override methods
    override var titleText: String {
        return PartyPointStrings.Localizable.onMap
    }
    
    override func setupUI() {
        self.addSubview(map)
        super.setupUI()
        map.layer.cornerRadius = ROOT_VIEW_CORNER_RADIUS
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        map.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(MAP_TOP_OFFSET)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: Public methods
    func configure(with location: PlaceAnnotationInfo) {
        map.centerToLocation(location.coordinate)
        map.addAnnotation(location)
    }
}

