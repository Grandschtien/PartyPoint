//
//  EventView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 19.08.2022.
//

import UIKit
import SnapKit

final class EventView: UIView {
    private let scrollView: UIScrollView = UIScrollView()
    private let backgroundImageView: UIImageView = UIImageView()
    private let imageContainerView: UIView = UIView()
    private let contentTable = EventInfoList(frame: .zero)
    
    private lazy var backgroundOfContentListView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainColor
        return view
    }()
    
    
    private var backgroundImageBottomConstraint: Constraint?
    private var backgroundImageHeightConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateArtistHeaderImageLayout(basedOn: scrollView)
    }
}

private extension EventView {
    func setupUI() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(imageContainerView)
        imageContainerView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.left.right.equalTo(self)
                make.height.equalTo(476.scale())
        }
        
        scrollView.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.left.right.equalTo(imageContainerView)
            make.top.equalTo(self)
            backgroundImageHeightConstraint = make.height.equalTo(501.scale()).constraint
            backgroundImageBottomConstraint = make.bottom.equalTo(imageContainerView.snp.bottom).inset(-25.scale()).constraint
        }
        backgroundImageHeightConstraint?.deactivate()

        scrollView.addSubview(backgroundOfContentListView)
        
        backgroundOfContentListView.snp.makeConstraints { make in
            make.top.equalTo(contentTable.snp.top).inset(25.scale())
            make.width.equalTo(self.snp.width)
            make.bottom.equalTo(self.snp.bottom)
        }

        scrollView.addSubview(contentTable)
        contentTable.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.bottom).offset(20.scale())
            make.width.equalTo(self.snp.width)
            make.bottom.equalToSuperview()
        }
    }

    func updateArtistHeaderImageLayout(basedOn scrollView: UIScrollView) {
        let yOffsetOfImageContainer = scrollView.convert(CGPoint(x: imageContainerView.frame.minX, y: imageContainerView.frame.minY), to: self).y

//        let topYCoordinateOfHeaderPrimaryButton = scrollView.convert(contentTable.frame, to: self).maxY - 44.scale()
//        onChangeOffsetOfHeaderBottomPoint?(topYCoordinateOfHeaderPrimaryButton)

        if yOffsetOfImageContainer > 0 {
            backgroundImageBottomConstraint?.activate()
            backgroundImageHeightConstraint?.deactivate()
            backgroundImageView.isHidden = false
        }
        else if abs(yOffsetOfImageContainer) >= imageContainerView.frame.height {
            backgroundImageView.isHidden = true
        }
        else {
            backgroundImageBottomConstraint?.deactivate()
            backgroundImageHeightConstraint?.activate()
            backgroundImageView.isHidden = false
        }
    }
}
