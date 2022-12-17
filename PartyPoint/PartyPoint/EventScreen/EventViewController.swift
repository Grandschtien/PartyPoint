//
//  EventViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 16.08.2022.
//  
//

import UIKit

final class EventViewController: UIViewController {
    enum NavigatioBarState {
        case hidden
        case noHidden
    }
    
    private let output: EventViewOutput
    private let navigationBar = NavigationBarWithLogoAndActions(
        image: nil,
        frame: .zero,
        buttons: [.back, .share],
        isImageNeed: false,
        isTitleNeeded: true
    )
    private let eventView = EventView()
    
    private var navBarCurrentState: NavigatioBarState = .hidden
    
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
        navigationBar.setTitle("Концерт басты", isHidden: true)
        eventView.delegate = self
        view.addSubview(navigationBar)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(statusBarFrame.height)
            $0.leading.trailing.equalToSuperview()
        }
        
        setActions()
    }
    
    func setActions() {
        navigationBar.setBackAction { [weak self] in
            self?.output.backAction()
        }
        
        navigationBar.setShareAction {
            //TODO: Share action
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

extension EventViewController: EventViewInput {
    
}


