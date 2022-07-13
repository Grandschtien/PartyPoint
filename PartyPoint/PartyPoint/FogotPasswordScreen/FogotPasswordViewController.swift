//
//  FogotPasswordViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import UIKit

final class FogotPasswordViewController: UIViewController {
    
    private lazy var navigationBar: NavigationBarWithLogoAndActions = {
        let navigationBar = NavigationBarWithLogoAndActions(
            frame: .zero,
            buttons: [.back],
            isImageNeed: true
        )
        navigationBar.delegate = self
        return navigationBar
    }()
    
	private let output: FogotPasswordViewOutput

    init(output: FogotPasswordViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        setupUI()
	}
    private func setupUI() {
        view.backgroundColor = .mainColor
        view.addConstrained(subview: navigationBar,
                             top: nil,
                             left: 0,
                             bottom: nil,
                             right: 0)
         NSLayoutConstraint.activate([
             navigationBar.heightAnchor.constraint(equalToConstant: 75),
             navigationBar.topAnchor.constraint(
                 equalTo: view.safeAreaLayoutGuide.topAnchor,
                 constant: 0
             )
         ])
    }
}

extension FogotPasswordViewController: FogotPasswordViewInput {
}

extension FogotPasswordViewController: NavigationBarWithLogoAndActionsDelegate {
    func backAction() {
        output.backButtonPressed()
    }
}
