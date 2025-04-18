//
//  PPSpinnerView.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 21.12.2022.
//

import UIKit
import PartyPointResources

public class PPSpinnerView: UIImageView {
    public enum Color {
        case black
        case white
        case main
        
        func color() -> UIColor? {
            switch self {
            case .black:
                return .black
            case .white:
                return PartyPointResourcesAsset.miniColor.color
            case .main:
                return PartyPointResourcesAsset.buttonColor.color
            }
        }
    }

    public enum SpinnerType {
        case s, m, l

        func size() -> CGSize {
            switch self {
            case .s:
                return CGSize(width: 16, height: 16)
            case .m:
                return CGSize(width: 24, height: 24)
            case .l:
                return CGSize(width: 60, height: 60)
            }
        }

        func image() -> UIImage? {
            switch self {
            case .s:
                return PartyPointResourcesAsset.icSpinnerS.image
            case .m:
                return PartyPointResourcesAsset.icSpinnerM.image
            case .l:
                return PartyPointResourcesAsset.icSpinnerL.image
            }
        }
    }
    
    // MARK: - Private properties
    
    public private(set) var isRotating: Bool = false

    // MARK: - Public properties

    public private(set) var type: SpinnerType
    var color: Color {
        didSet {
            self.tintColor = color.color()
        }
    }
    
    // MARK: - Init
    public init(type: SpinnerType, color: Color = .black) {
        self.type = type
        self.color = color
        super.init(frame: .zero)
        image = type.image()?.withRenderingMode(.alwaysTemplate)
        tintColor = color.color()

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Layout

    public override var intrinsicContentSize: CGSize {
        return type.size()
    }

    // MARK: - Public methods
    public func startAnimation() {
        isRotating = true
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.repeatCount = Float.greatestFiniteMagnitude
        rotation.isRemovedOnCompletion = false
        layer.add(rotation, forKey: "rotationAnimation")
    }

    public func stopAnimation() {
        isRotating = false
        layer.removeAllAnimations()
    }
}
