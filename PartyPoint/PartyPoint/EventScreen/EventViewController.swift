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
    
    private lazy var navigationBar: NavigationBarWithLogoAndActions = {
        let navBar = NavigationBarWithLogoAndActions(frame: .zero, buttons: [.back, .share])
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
    init(output: EventViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}
private extension EventViewController {
    func setupUI() {
        navigationBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension EventViewController: EventViewInput {
    
}


