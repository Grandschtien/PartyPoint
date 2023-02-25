//
//  SearchScreenContentView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 24.02.2023.
//  
//

import SnapKit

final class SearchScreenContentView: UIView {
    
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
private extension SearchScreenContentView {
    func setupUI() {
        setupConstraints()
    }
    
    func setupConstraints() {
        
    }
}

// MARK: Public methods
extension SearchScreenContentView {
    
}


