//
//  PPToastCountDownView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import UIKit

class PPToastCountdownView: UIView {

    // MARK: - Properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = PartyPointFontFamily.SFProDisplay.regular.font(size: 14)
        label.textColor = PartyPointAsset.mainColor.color
        label.textAlignment = .center
        return label
    }()

    private var progressLayer: CAShapeLayer?

    private var timer: Timer?

    private var initialSeconds = 0
    private var secondsRemain = 0

    // MARK: - Init

    convenience init(seconds: Int) {
        self.init(frame: .zero)
        initialSeconds = seconds
        self.secondsRemain = seconds
        setupView()

        updateTitle()
    }

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()

        if progressLayer == nil {
            createProgressLayer()
        }
    }

    // MARK: - Methods

    func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(update)), userInfo: nil, repeats: true)
    }

    @objc
    func update() {
        secondsRemain -= 1

        updateTitle()

        let secondCirclePart: CGFloat = 1 / CGFloat(initialSeconds)
        progressLayer?.strokeEnd = secondCirclePart * CGFloat(secondsRemain)

        if secondsRemain <= 0 {
            timer?.invalidate()
        }
    }

    func updateTitle() {
        titleLabel.text = "\(secondsRemain)"
    }

    func setupView() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])

        runTimer()
    }

    func createProgressLayer() {

        let progressLayer = CAShapeLayer()

        let radius = frame.size.width / 2

        let circularPath = UIBezierPath(arcCenter: CGPoint(x: radius, y: radius),
                                        radius: radius,
                                        startAngle: 3 * .pi / 2,
                                        endAngle: -.pi / 2 ,
                                        clockwise: false)
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 2.0
        progressLayer.strokeColor = UIColor.red.cgColor

        layer.addSublayer(progressLayer)

        self.progressLayer = progressLayer
    }
}

