//
//  PPRefreshControl.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 26.02.2023.
//

import SnapKit

import UIKit

// MARK: - Constants

enum PPPullToRefreshConstants {
    static let alpha = true
    static let height: CGFloat = 40
    static let maxPullDistance: CGFloat = 150
}

final class PPRefreshControlView: UIView {
    
    // MARK: - Enum
    
    enum MTSRefreshState {
        case pulling
        case triggered
        case refreshing
        case stop
        case finish
    }
    
    // MARK: - Private Variables
    
    fileprivate var backgroundView: UIView
    fileprivate var spinnerView: PPSpinnerView
    fileprivate var scrollViewInsets: UIEdgeInsets = UIEdgeInsets.zero
    fileprivate var refreshCompletion: (() -> Void)?
    fileprivate var positionY: CGFloat = 0
    fileprivate let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    fileprivate var isHapticsDone: Bool = false
    
    // MARK: - Variables
    
    let contentOffsetKeyPath = "contentOffset"
    let contentSizeKeyPath = "contentSize"
    static var kvoContext = "PullToRefreshKVOContext"

    var state: MTSRefreshState = MTSRefreshState.pulling {
        didSet {
            if self.state == oldValue {
                return
            }
            switch self.state {
            case .stop:
                stopAnimating()
            case .finish:
                var duration = 0.5
                var time = DispatchTime.now() + Double(Int64(duration * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: time) {
                    self.stopAnimating()
                }
                duration = duration * 2
                time = DispatchTime.now() + Double(Int64(duration * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                DispatchQueue.main.asyncAfter(deadline: time) {
                    self.removeFromSuperview()
                }
            case .refreshing:
                startAnimating()
            case .triggered:
                if isHapticsDone == false {
                    feedbackGenerator.impactOccurred()
                    isHapticsDone = true
                }
            case .pulling:
                isHapticsDone = false
            }
        }
    }
    
    // MARK: - Init
    
    public override convenience init(frame: CGRect) {
        self.init(spinnerColor: .black, frame: frame, refreshCompletion: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(spinnerColor: PPSpinnerView.Color, frame: CGRect, refreshCompletion: (() -> Void)?) {
        self.refreshCompletion = refreshCompletion

        backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        
        spinnerView = PPSpinnerView(type: .m, color: spinnerColor)

        super.init(frame: frame)
        self.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { $0.edges.equalToSuperview() }
        backgroundView.addSubview(spinnerView)
        spinnerView.snp.makeConstraints { $0.center.equalToSuperview() }
        autoresizingMask = .flexibleWidth
    }
    
    override func willMove(toSuperview superView: UIView!) {
        self.removeRegister()
        guard let scrollView = superView as? UIScrollView else {
            return
        }
        scrollView.addObserver(self, forKeyPath: contentOffsetKeyPath, options: .initial, context: &PPRefreshControlView.kvoContext)
    }
    
    fileprivate func removeRegister() {
        if let scrollView = superview as? UIScrollView {
            scrollView.removeObserver(self, forKeyPath: contentOffsetKeyPath, context: &PPRefreshControlView.kvoContext)
        }
    }
    
    deinit {
        self.removeRegister()
    }
    
    // MARK: - KVO
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let scrollView = object as? UIScrollView else {
            return
        }
        if keyPath == contentSizeKeyPath {
            self.positionY = scrollView.contentSize.height
            return
        }
        
        if !(context == &(PPRefreshControlView.kvoContext) && keyPath == contentOffsetKeyPath) {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        let offsetY = scrollView.contentOffset.y
        
        if PPPullToRefreshConstants.alpha {
            var alpha = abs(offsetY) / (self.frame.size.height + 40)
            if alpha > 0.8 {
                alpha = 0.8
            }
            spinnerView.alpha = alpha
        }
        
        if !(scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0) && offsetY >= -PPPullToRefreshConstants.maxPullDistance {
            isHapticsDone = false
        }

        updateAnimation(with: offsetY)
        
        if offsetY <= 0 {
            if offsetY < -PPPullToRefreshConstants.maxPullDistance {
                if scrollView.isDragging == false && self.state != .refreshing {
                    self.state = .refreshing
                } else if self.state != .refreshing {
                    self.state = .triggered
                }
            } else if self.state == .triggered {
                self.state = .pulling
            }
        }
    }
}

// MARK: - Private methods

fileprivate extension PPRefreshControlView {
    func startAnimating() {
        spinnerView.transform = CGAffineTransform(rotationAngle: -(2 * CGFloat(Double.pi / 180))).scaledBy(x: 1.0, y: 1.0)
        spinnerView.startAnimation()
        guard let scrollView = superview as? UIScrollView else {
            return
        }
        scrollViewInsets = scrollView.contentInset
        
        var insets = scrollView.contentInset
        insets.top += PPPullToRefreshConstants.height
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options:[],
            animations: {
                scrollView.contentInset = insets
            },
            completion: { _ in
                self.refreshCompletion?()
            }
        )
    }
    
    func stopAnimating() {
        guard let scrollView = superview as? UIScrollView else {
            return
        }
        scrollViewInsets = .zero
        spinnerView.stopAnimation()
        spinnerView.isHidden = true
        UIView.animate(
            withDuration: 0.2,
            animations: {
                scrollView.contentInset = self.scrollViewInsets
            }, completion: { _ in
                self.state = .pulling
                self.spinnerView.isHidden = false
            }
        )
    }
    
    func updateAnimation(with offsetY: CGFloat) {
        if spinnerView.isRotating {
            return
        }
        let scaleFirst = max(0.2, -offsetY/PPPullToRefreshConstants.maxPullDistance)
        let scale = min(1.0, scaleFirst)
        let angle = -offsetY * 2 * CGFloat(Double.pi / 180) - CGFloat(Double.pi / 180)
        
        if angle*1.4 >= 2 * Double.pi {
            spinnerView.transform = CGAffineTransform(rotationAngle: -(2 * CGFloat(Double.pi / 180))).scaledBy(x: scale, y: scale)
            return
        }
        spinnerView.transform = CGAffineTransform(rotationAngle: 1.4 * (-angle)).scaledBy(x: scale, y: scale)
    }
}

