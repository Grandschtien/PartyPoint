//
//  ProfileViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//  
//

import SnapKit

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
}

private extension ProfileViewController {
    func setupUI() {
        view.addSubview(contentView)
        navigationController?.setNavigationBarHidden(true, animated: true)
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


