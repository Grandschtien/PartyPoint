//
//  RegisterViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 13.07.2022.
//  
//

import SnapKit

final class RegisterViewController: UIViewController {
    
    private let contentView = RegisterView()
    
    private let output: RegisterViewOutput
    
    init(output: RegisterViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setActions()
    }
}

private extension RegisterViewController {
    func setActions() {
        contentView.setBackAction { [weak self] in
            self?.output.backButtonPressed()
        }
        
        contentView.setRegisterAction { [weak self] info in
            Task {
                await self?.output.registeButtonPressed(registerInfo: info)
            }
        }
    }
}

extension RegisterViewController: RegisterViewInput { }

