//
//  EventInfoList.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 19.08.2022.
//

import UIKit
import SnapKit

//Constants

private let VERTICAL_OFFSET = 17.scale()
private let HORISONTAL_OFFSET = 15.scale()
private let HEADER_OFFSET = 10.scale()

final class EventInfoView: UIView {
    
    private let header = EventHeaderLabel(frame: .zero, labelType: .main)
    private let locationView = LocationView()
    private let descriptionView = DescriptionEventView()
    private let costView =  EventViewWithButton()
    private let goView = EventViewWithButton()
    private let mapView = EventMapView()
    
    private var fullHeight: CGFloat?
    
    var height: CGFloat {
        return fullHeight ?? 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        fullHeight = countHeight()
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
        header.text = "Концерт Басты"
        
        addSubview(locationView)
        locationView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom).offset(VERTICAL_OFFSET)
            $0.leading.equalToSuperview().offset(HORISONTAL_OFFSET)
            $0.trailing.equalToSuperview().inset(HORISONTAL_OFFSET)
            $0.height.equalTo(34.scale())
        }
        
        addSubview(descriptionView)
        descriptionView.snp.makeConstraints {
            $0.top.equalTo(locationView.snp.bottom).offset(VERTICAL_OFFSET)
            $0.leading.equalToSuperview().offset(HORISONTAL_OFFSET)
            $0.trailing.equalToSuperview().inset(HORISONTAL_OFFSET)
            $0.height.equalTo(247.scale())
        }

        addSubview(costView)
        costView.snp.makeConstraints {
            $0.top.equalTo(descriptionView.snp.bottom).offset(VERTICAL_OFFSET)
            $0.leading.equalToSuperview().offset(HORISONTAL_OFFSET)
            $0.trailing.equalToSuperview().inset(HORISONTAL_OFFSET)
            $0.height.equalTo(122.scale())
        }

        addSubview(goView)
        goView.snp.makeConstraints {
            $0.top.equalTo(costView.snp.bottom).offset(VERTICAL_OFFSET)
            $0.leading.equalToSuperview().offset(HORISONTAL_OFFSET)
            $0.trailing.equalToSuperview().inset(HORISONTAL_OFFSET)
            $0.height.equalTo(122.scale())
        }

        self.addSubview(mapView)

        mapView.snp.makeConstraints {
            $0.top.equalTo(goView.snp.bottom).offset(VERTICAL_OFFSET)
            $0.leading.equalToSuperview().offset(HORISONTAL_OFFSET)
            $0.trailing.equalToSuperview().inset(HORISONTAL_OFFSET)
            $0.height.equalTo(180.scale())
        }
        //mock
        locationView.updateWithLocationDateAndTime("Ленинградский пр-т., 80, к. 17, Москва", "22.07.2022", "18:00")
        
        descriptionView.backgroundColor = .green
        costView.backgroundColor = .green
        goView.backgroundColor = .green
        mapView.backgroundColor = .green
        
    }
    
    func countHeight() -> CGFloat {
        let height = VERTICAL_OFFSET * 5 + HEADER_OFFSET + header.frame.size.height + locationView.frame.size.height + descriptionView.frame.size.height + costView.frame.size.height + goView.frame.size.height + mapView.frame.size.height
        return height
    }
}
