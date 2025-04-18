//
//  EventView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 19.08.2022.
//

import UIKit
import SnapKit
import PartyPointDesignSystem
import PartyPointResources

protocol EventViewDelegate: AnyObject {
    func setNavTitleVisibleIfNeeded(offset: CGFloat)
}

private let CORNER_RADIUS = 20.scale()
private let COLOR_BACKGROUND_OFFSET = -20.scale()
private let SCROLL_VIEW_INSETS = 46.scale()

final class EventView: UIView {
    
    private let navigationBar = SharingNavigationBar()
    private let scrollView = UIScrollView()
    private let backgroundImageView = AcyncImageView(placeHolderType: .event)
    private let eventInfoView = EventInfoView(frame: .zero)
    private lazy var backgroundOfContentListView = UIView()
    
    var onChangeOffsetOfHeaderBottomPoint: ((CGFloat) -> Void)?
    private var backgroundImageContainerBottomConstraint: Constraint?
    private var backgroundImageTopConstaint: Constraint?
    
    private var previousStatusBarHidden = false

    weak var delegate: EventViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeScrollViewSize()
    }
}

extension EventView {
    func configureView(withEvent event: EventFullInfo) {
        backgroundImageView.setImage(url: event.imageURL)
        eventInfoView.configure(withInfo: event)
        layoutIfNeeded()
    }
    
    func setVisibility(isHidden: Bool) {
        scrollView.isHidden = isHidden
    }
    
    func setOpenSuperviserSite(_ action: @escaping (() -> Void)) {
        self.eventInfoView.setOpenSuperviserSite(action)
    }
    
    func showNavBar() {
        navigationBar.backgroundColor = PartyPointResourcesAsset.mainColor.color
        navigationBar.tintColor = PartyPointResourcesAsset.mainColor.color
        navigationBar.fontColor(color: PartyPointResourcesAsset.miniColor.color)
    }
    
    func hideNavBar() {
        navigationBar.backgroundColor = .clear
        navigationBar.tintColor = .clear
        navigationBar.fontColor(color: .clear)
    }
    
    func setNavigatioNBarTitle(title: String) {
        navigationBar.setTitle(title)
    }
    
    func setBackAction(_ action: @escaping (() -> Void)) {
        navigationBar.setBackAction(action)
    }
    
    func setShareAction(_ action: @escaping (() -> Void)) {
        navigationBar.setShareAction(action)
    }
}

extension EventView: UIScrollViewDelegate {
    //TODO: Hight priority: make navigation bar animation.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let backGroundPosition = scrollView.convert(CGPoint(x: backgroundOfContentListView.frame.minX, y: backgroundOfContentListView.frame.minY), to: self).y
        delegate?.setNavTitleVisibleIfNeeded(offset: backGroundPosition)
    }
}

private extension EventView {
    func setupLayers() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.resignFirstResponder()
    }
    
    func setupUI() {
        backgroundOfContentListView.backgroundColor = PartyPointResourcesAsset.mainColor.color
        
        
        let imageContainer = UIView()
        imageContainer.backgroundColor = .darkGray
        
        let backColorView = UIView()
        backColorView.backgroundColor = PartyPointResourcesAsset.mainColor.color
        backColorView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backColorView.layer.cornerRadius = CORNER_RADIUS
        
        addSubview(scrollView)
        addSubview(navigationBar)
        scrollView.addSubview(imageContainer)
        scrollView.addSubview(backColorView)
        scrollView.addSubview(backgroundImageView)
        scrollView.addSubview(backgroundOfContentListView)
        backgroundOfContentListView.addSubview(eventInfoView)
        
        navigationBar.snp.makeConstraints {
            $0.height.equalTo(navigationBar.height)
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(statusBarFrame.height)
        }

        scrollView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        imageContainer.snp.makeConstraints {
            $0.top.equalTo(scrollView)
            $0.left.right.equalTo(self)
            $0.height.equalTo(imageContainer.snp.width).multipliedBy(0.9)
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.left.right.equalTo(imageContainer)
            $0.top.equalTo(self).priority(.high)
            $0.height.greaterThanOrEqualTo(imageContainer.snp.height).priority(.required)
            $0.bottom.equalTo(imageContainer.snp.bottom)
        }
        
        backgroundOfContentListView.snp.makeConstraints {
            $0.top.equalTo(imageContainer.snp.bottom)
            $0.left.right.equalTo(self)
            $0.bottom.equalTo(self)
        }
        
        backColorView.snp.makeConstraints {
            $0.left.right.equalTo(self)
            $0.top.equalTo(backgroundOfContentListView).offset(COLOR_BACKGROUND_OFFSET)
            $0.bottom.equalTo(self)
        }
        
        eventInfoView.snp.makeConstraints {
            $0.edges.equalTo(backgroundOfContentListView)
        }
        
        scrollView.bringSubviewToFront(backColorView)
        scrollView.bringSubviewToFront(backgroundOfContentListView)
        scrollView.contentInset.bottom = SCROLL_VIEW_INSETS
        
        setupNavigatioBar()
    }
    
    func setupNavigatioBar() {
        navigationBar.fontColor(color: .clear)
    }
    
    func makeScrollViewSize() {
        let height = backgroundImageView.frame.size.height + eventInfoView.height
        scrollView.contentSize = CGSize(width: self.frame.width, height: height)
    }
}
