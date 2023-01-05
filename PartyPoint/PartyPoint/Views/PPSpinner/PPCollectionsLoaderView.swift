//
//  PPCollectionsLoaderView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 05.01.2023.
//

import SnapKit

final class PPCollectionsLoaderView: UICollectionReusableView {
    private let spinnerView = PPSpinnerView(type: .s, color: .main)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    func startAnimation() {
        spinnerView.startAnimation()
    }
    
    func stopAnimation() {
        spinnerView.stopAnimation()
    }
}

private extension PPCollectionsLoaderView {
    func setupUI() {
        self.addSubview(spinnerView)
        spinnerView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
