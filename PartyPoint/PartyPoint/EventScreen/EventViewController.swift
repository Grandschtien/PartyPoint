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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.setNavigationBarHidden(false, animated: true)
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
        changeStatusBarColor(.clear)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func setActions() {
        eventView.setBackAction { [weak self] in
            self?.output.backAction()
        }

        eventView.setShareAction { [weak self] in
            self?.output.shareEvent()
        }
        
        eventView.setOpenSuperviserSite { [weak self] in
            self?.output.openSuperviserSite()
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
        eventView.setNavigatioNBarTitle(title: info.title)
        eventView.configureView(withEvent: info)
    }
    
    func setLoaderVisibility(isHidden: Bool) {
        eventView.setVisibility(isHidden: !isHidden)
        isHidden ? hideLoader() : showLoader()
    }
    
    func showNavBar() {
        UIView.animate(withDuration: 0.3) { [self] in
            changeStatusBarColor(Colors.mainColor())
            eventView.showNavBar()
        }
    }
    
    func hideNavBar() {
        UIView.animate(withDuration: 0.3) { [self] in
            changeStatusBarColor(.clear)
            eventView.hideNavBar()
        }
    }
}

extension EventViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
