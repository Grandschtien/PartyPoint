//
//  ChooseCityViewController.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 08.05.2023.
//  
//
import UIKit

final class ChooseCityViewController: UIViewController {
    
    // MARK: Private propeties
    private let presenter: ChooseCityPresenter
    private let contentView = ChooseCityContentView()
    
    // MARK: Init
    init(presenter: ChooseCityPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setActions()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: Overriden methods
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func setActions() {
        contentView.setCloseAction { [weak self] in
            self?.dismiss(animated: true)
        }
        
        contentView.setChooseCityAction { [weak self] city in
            self?.presenter.updateChosenCity(city: city)
        }
        
        contentView.setConfirmChoseAction { [weak self] in
            self?.presenter.confirmChose()
        }
    }
}

// MARK: ChooseCityView
extension ChooseCityViewController: ChooseCityView {
    func setCurrentCity(city: String) {
        contentView.setChosenCity(city)
    }
    
    func dismiss() {
        self.dismiss(animated: true)
    }
}
