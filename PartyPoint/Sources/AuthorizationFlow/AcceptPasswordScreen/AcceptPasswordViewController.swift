//
//  AcceptPasswordViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 08.02.2023.
//

import SnapKit
import UIKit

final class AcceptPasswordViewController: UIViewController {
    private let contentView = ForgotPasswordView()
    private let presenter: AcceptPasswordPresenter
    
    init(presenter: AcceptPasswordPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupActions()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func loadView() {
        view = contentView
        contentView.configure(with: R.string.localizable.enter_code(),
                              btnTitle: R.string.localizable.confirm(),
                              textFieldPlaceholder: R.string.localizable.code())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.isNavigationBarHidden = false
    }
}

private extension AcceptPasswordViewController {
    func setupActions() {
        contentView.setCloseAction { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        contentView.setSendAction { [weak self] code in
            self?.presenter.sendCode(code: code)
        }
    }
}

extension AcceptPasswordViewController: AcceptPassswordView {
    func showError(reason: String) {
        contentView.showError(text: reason)
    }
    
    func performSuccess(email: String){
        let changePasswordAssembly = ChangePasswordAssembly.assemble(creditail: email, state: .resetPassword)
        self.navigationController?.pushViewController(changePasswordAssembly.viewController,
                                                      animated: true)
    }
    
    func showLoader(isLoading: Bool) {
        contentView.setIsLoading(isLoading: isLoading)
    }
}
