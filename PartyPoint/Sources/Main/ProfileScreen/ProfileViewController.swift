//
//  ProfileViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import SnapKit
import UIKit

final class ProfileViewController: UIViewController {
    
    private let contentView = ProfileContentView()
    private let output: ProfileViewOutput
    
    init(output: ProfileViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        setupActions()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        output.onViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

private extension ProfileViewController {
    func setupUI() {
        view.addSubview(contentView)
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        contentView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalToSuperview()
        }
    }
    
    func setupActions() {
        contentView.setBackAction { [weak self] in
            self?.output.backActionTapped()
        }
        
        contentView.setExitAction { [weak self] in
            self?.output.exitActionTapped()
        }
        
        contentView.setChangePasswordAction { [weak self] in
            self?.output.changePasswordActionTapped()
        }
        
        contentView.setChangeCityAction { [weak self] in
            self?.output.changeCityActionTapped()
        }
    }
}

extension ProfileViewController: ProfileViewInput {
    func configureView(withInfo info: ProfileInfo) {
        contentView.configure(withInfo: info)
    }
    
    func setLoaderVisibility(isLoading: Bool) {
        contentView.setExitButtonLoader(isLoading: isLoading)
    }
}


extension ProfileViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension ProfileViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
           return HalfScreenPresentationController(presentedViewController: presented, presenting: presenting)
       }
}

