//
//  PPButtonBase.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import UIKit

open class PPButtonBase: UIButton {

    // MARK: - Public properties
    public var touchUpAction: ((PPButtonBase) -> ())?
    public var pressUpAction: ((PPButtonBase) -> ())?

    // MARK: - Private properties
    private var lastTouch: UITouch?

    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Private methods
    func setupView() {
        setupControlAnimation()

        addTarget(self,
                  action: #selector(touchUp),
                  for: .touchUpInside)
    }

    @objc func touchUp() {
        touchUpAction?(self)
    }

    // MARK: - Override methods
    override func upAnimationCompleted() {
        guard let touchLocation = lastTouch?.location(in: self) else {
            return
        }

        if bounds.contains(touchLocation) {
            pressUpAction?(self)
        }
    }

    // MARK: - UIControl tracking
    open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        lastTouch = nil
        return super.beginTracking(touch, with: event)
    }

    open override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lastTouch = touch
        super.endTracking(touch, with: event)
    }
}
