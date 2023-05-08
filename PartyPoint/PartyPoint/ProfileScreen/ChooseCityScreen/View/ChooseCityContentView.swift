//
//  ChooseCityContentView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 08.05.2023.
//  
//

import SnapKit

final class ChooseCityContentView: UIView {
    
    // MARK: Private properties
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: Private methods
private extension ChooseCityContentView {
    func setupUI() {
        setupConstraints()
        view.backgroundColor = Colors.mainColor()
    }
    
    func setupConstraints() {
        
    }
}

// MARK: Public methods
extension ChooseCityContentView {
    
}


