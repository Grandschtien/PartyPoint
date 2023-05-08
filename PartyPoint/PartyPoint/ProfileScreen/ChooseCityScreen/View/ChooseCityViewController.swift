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
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: Overriden methods
    override func loadView() {
        view = contentView
    }
}

// MARK: Private methods
private extension ChooseCityViewController {
    
}

// MARK: Public methods
extension ChooseCityViewController {
    
}

// MARK: ChooseCityView
extension ChooseCityViewController: ChooseCityView {
    
}
