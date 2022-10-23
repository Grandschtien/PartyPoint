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
    
    private let navigationBar = NavigationBarWithLogoAndActions(
        image: nil,
        frame: .zero,
        buttons: [.back, .share],
        isImageNeed: false,
        isTitleNeeded: true
    )
    
    private let eventView = EventView()
    
    init(output: EventViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
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
        view.backgroundColor = Colors.mainColor()
        navigationBar.delegate = self
        navigationBar.setTitle("Концерт басты", isHidden: true)
        eventView.delegate = self
        view.addSubview(navigationBar)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension EventViewController: EventViewDelegate {
    func setNavTitleVisibleIfNeeded(offset: CGFloat) {
        if offset <= 76 {
            navigationBar.setTitle("Концерт басты", isHidden: false)
            navigationBar.backgroundColor = Colors.mainColor()
            changeStatusBarColor(Colors.mainColor())
        } else {
            navigationBar.setTitle("Концерт басты", isHidden: true)
            navigationBar.backgroundColor = .clear
            changeStatusBarColor(.clear)
        }
    }
}

extension EventViewController: NavigationBarWithLogoAndActionsDelegate {
    func backAction() {
        output.backAction()
    }
    
    func shareAction() {}
}

extension EventViewController: EventViewInput {
    
}


