//
//  PPSearchBar.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 18.03.2023.
//

import SnapKit
import UIKit

final class PPSearchBar: UISearchBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setupUI() {
    }
}
