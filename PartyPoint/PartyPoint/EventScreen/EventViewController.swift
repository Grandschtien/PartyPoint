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
    
    private let navigationBar = SharingNavigationBar()
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
        output.onViewDidLoad()
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.transform = .identity
    }
    
    override func loadView() {
        view = eventView
    }
}

private extension EventViewController {
    func setupUI() {
        view.backgroundColor = Colors.mainColor()
        eventView.delegate = self
        setupNavigationBar()
        
        setActions()
    }
    
    func setupNavigationBar() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.isNavigationBarHidden = false
        navigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: navigationBar.height)
        navigationBar.backgroundColor = .clear
        navigationBar.fontColor(color: .clear)
        navigationItem.titleView = navigationBar
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
        output.changeVisibilityOfNavBar(offset: offset)
    }
}

extension EventViewController: EventViewInput {
    func setupView(withInfo info: EventFullInfo) {
        navigationBar.setTitle(info.title)
        eventView.configureView(withEvent: info)
    }
    
    func setLoaderVisibility(isHidden: Bool) {
        eventView.setVisibility(isHidden: !isHidden)
        isHidden ? hideLoader() : showLoader()
    }
    
    func showNavBar() {
        UIView.animate(withDuration: 0.3) { [self] in
            changeStatusBarColor(Colors.mainColor())
            navigationController?.navigationBar.barTintColor = Colors.mainColor()
            navigationController?.navigationBar.backgroundColor = Colors.mainColor()
            navigationController?.navigationBar.tintColor = Colors.mainColor()
            navigationBar.fontColor(color: Colors.miniColor())
        }
    }
    
    func hideNavBar() {
        UIView.animate(withDuration: 0.3) { [self] in
            changeStatusBarColor(.clear)
            navigationController?.navigationBar.barTintColor = .clear
            navigationController?.navigationBar.backgroundColor = .clear
            navigationController?.navigationBar.tintColor = .clear
            navigationBar.fontColor(color: .clear)
        }
    }
}


