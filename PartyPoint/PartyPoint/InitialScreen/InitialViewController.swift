//
//  InitialViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit

final class InitialViewController: UIViewController {
    
    private var router: InitilaRouterProtocol?
    
    private lazy var navigationBar: NavigationBarWithLogo = {
        let navigationBar = NavigationBarWithLogo(frame: .zero)
        return navigationBar
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = .mainColor
        return view
    }()
    
    private lazy var initLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.font = UIFont(name: UIFont.SFProDisplaySemibold, size: 25)
        label.text = LabelTexts.initLabel.rawValue
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var goButton: AppButton = {
        let button = AppButton(withTitle: LabelTexts.goButton.rawValue)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.action =  { [weak self] in
            self?.buttonTapped()
        }
        return button
    }()
    private lazy var userOfferLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: UIFont.SFProDisplaySemibold, size: 12)
        label.text = LabelTexts.userOfferLabel.rawValue
        label.textAlignment = .center
        label.numberOfLines = 2
        label.alpha = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(router: InitilaRouterProtocol) {
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
        view.layer.contents = UIImage.concert?.cgImage
        view.addConstrained(subview: navigationBar,
                            top: nil,
                            left: 0,
                            bottom: nil,
                            right: 0)
        navigationBar.heightAnchor.constraint(equalToConstant: 78).isActive = true
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
        view.addConstrained(subview: bottomView,
                            top: nil,
                            left: 0,
                            bottom: 0,
                            right: 0)
        bottomView.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        bottomView.addConstrained(subview: initLabel,
                                  top: 19,
                                  left: 15,
                                  bottom: nil,
                                  right: -15)
        bottomView.addSubview(goButton)
        NSLayoutConstraint.activate([
            goButton.topAnchor.constraint(equalTo: initLabel.bottomAnchor, constant: 25),
            goButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 15),
            goButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -15),
            goButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        bottomView.addSubview(userOfferLabel)
        NSLayoutConstraint.activate([
            userOfferLabel.topAnchor.constraint(equalTo: goButton.bottomAnchor, constant: 25),
            userOfferLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 15),
            userOfferLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -15),
        ])
    }
}

extension InitialViewController {
    func buttonTapped() {
        router?.navigateToEnter()
    }
}

