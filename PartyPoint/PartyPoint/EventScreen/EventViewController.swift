//
//  EventViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 16.08.2022.
//  
//

import UIKit

final class EventViewController: UIViewController {
    
	private let output: EventViewOutput
    
    private lazy var navigationBar = NavigationBarWithLogoAndActions(
        image: nil,
        frame: .zero,
        buttons: [.back, .share]
    )
    private let eventView = EventView()
    
    init(output: EventViewOutput) {
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
    override func loadView() {
        view = eventView
    }
}

private extension EventViewController {
    func setupUI() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .mainColor
        view.addSubview(navigationBar)

        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension EventViewController: EventViewInput {
    
}


