//
//  InitialViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit
import SnapKit

private let NAVIGATION_BAR_HEIGHT: CGFloat = 78
private let INIT_LABEL_TOP_OFFSET: CGFloat = 19
private let HORIZONTAL_OFFSETS_INIT_LABEL: CGFloat = 15
private let GO_BUTTON_BOTTOM_OFFSET: CGFloat = 25
private let GO_BUTTON_HORIZONTAL_OFFSETS: CGFloat = 15
private let GO_BUTTON_HEIGHT: CGFloat = 56
private let USER_OFFER_TOP_OFFSET: CGFloat = 25
private let USER_OFFER_HORIZONTAL_OFFSETS: CGFloat = 15

final class InitialViewController: UIViewController {
    
    private var router: InitialRouter?
    
    private lazy var navigationBar: NavigationBarWithLogo = {
        let navigationBar = NavigationBarWithLogo(frame: .zero)
        return navigationBar
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = PartyPointAsset.mainColor.color
        return view
    }()
    
    private lazy var initLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = PartyPointFontFamily.SFProDisplay.semibold.font(size: 25)
        label.text = PartyPointStrings.Localizable.initLabel
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var goButton: PPButton = {
        let button = PPButton(style: .primary, size: .l)
        button.setTitle(PartyPointStrings.Localizable.goButtonTitle, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var userOfferLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = PartyPointFontFamily.SFProDisplay.semibold.font(size: 12)
        label.text = PartyPointStrings.Localizable.userOffer
        label.textAlignment = .center
        label.numberOfLines = 2
        label.alpha = 0.5
        return label
    }()
    
    init(router: InitialRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        
        view.layer.contents = PartyPointAsset.concert.image.cgImage
        view.addSubview(navigationBar)
        view.addSubview(bottomView)
        bottomView.addSubview(initLabel)
        bottomView.addSubview(goButton)
        bottomView.addSubview(userOfferLabel)
        
        navigationBar.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(NAVIGATION_BAR_HEIGHT.scale())
        }
        
        bottomView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(view.frame.height / 3)
        }
        
        initLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(HORIZONTAL_OFFSETS_INIT_LABEL.scale())
            $0.top.equalToSuperview().offset(INIT_LABEL_TOP_OFFSET.scale())
            $0.right.equalToSuperview().inset(HORIZONTAL_OFFSETS_INIT_LABEL.scale())
        }
        
        goButton.snp.makeConstraints {
            $0.top.equalTo(initLabel.snp.bottom).offset(GO_BUTTON_BOTTOM_OFFSET.scale())
            $0.left.equalToSuperview().offset(GO_BUTTON_HORIZONTAL_OFFSETS.scale())
            $0.right.equalToSuperview().inset(GO_BUTTON_HORIZONTAL_OFFSETS.scale())
            $0.height.equalTo(GO_BUTTON_HEIGHT.scale())
            
        }
        userOfferLabel.snp.makeConstraints {
            $0.top.equalTo(goButton.snp.bottom).offset(USER_OFFER_TOP_OFFSET.scale())
            $0.right.equalToSuperview().inset(USER_OFFER_HORIZONTAL_OFFSETS.scale())
            $0.left.equalToSuperview().offset(USER_OFFER_TOP_OFFSET.scale())
        }
    }
}

extension InitialViewController {
    @objc
    func buttonTapped() {
        router?.navigateToEnter()
    }
}

