import SnapKit
import UIKit
import PartyPointResources

private let BUTTON_LABEL_FONT_SIZE: CGFloat = 17.scale()
private let SELF_CORENR_RADIUS: CGFloat = 15.scale()
private let SEPARATE_VIEW_HEIGHT: CGFloat = 1
private let HORIZONTAL_CONTROL_OFFSETS: CGFloat = 10

final class CalendarPickerFooterView: UIView {
    private let separatorView = UIView()
    private let previousMonthButton = UIButton()
    private let nextMonthButton = UIButton()
    
    private var didTapLastMonthCompletionHandler: (() -> Void)?
    private var didTapNextMonthCompletionHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        previousMonthButton.titleLabel?.font = PartyPointResourcesFontFamily.SFProDisplay.medium.font(size: BUTTON_LABEL_FONT_SIZE)
        nextMonthButton.titleLabel?.font = PartyPointResourcesFontFamily.SFProDisplay.medium.font(size: BUTTON_LABEL_FONT_SIZE)
    }
    
    func setNextMonthAction(_ action: @escaping (() -> Void)) {
        self.didTapNextMonthCompletionHandler = action
    }
    
    func setPrevMonthAction(_ action: @escaping (() -> Void)) {
        self.didTapLastMonthCompletionHandler = action
    }
}

private extension CalendarPickerFooterView {
    func setupConstraints() {
        separatorView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(SEPARATE_VIEW_HEIGHT)
        }
        
        previousMonthButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(HORIZONTAL_CONTROL_OFFSETS)
            $0.centerY.equalToSuperview()
        }
        
        nextMonthButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(HORIZONTAL_CONTROL_OFFSETS)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = PartyPointResourcesAsset.mainColor.color
        
        layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
        layer.cornerCurve = .continuous
        layer.cornerRadius = SELF_CORENR_RADIUS
        
        addSubview(separatorView)
        addSubview(previousMonthButton)
        addSubview(nextMonthButton)
        
        setupBackButton()
        setupNextButton()
        setupSeparatedView()
        
        setupConstraints()
    }
    
    func setupNextButton() {
        nextMonthButton.titleLabel?.font = PartyPointResourcesFontFamily.SFProDisplay.medium.font(size: BUTTON_LABEL_FONT_SIZE)
        nextMonthButton.titleLabel?.textAlignment = .right
        
        if let chevronImage = UIImage(systemName: "chevron.right.circle.fill") {
            let imageAttachment = NSTextAttachment(image: chevronImage)
            let attributedString = NSMutableAttributedString(string: "\(PartyPointResourcesStrings.Localizable.next) ")
            
            attributedString.append(
                NSAttributedString(attachment: imageAttachment)
            )
            
            nextMonthButton.setAttributedTitle(attributedString, for: .normal)
        } else {
            nextMonthButton.setTitle(PartyPointResourcesStrings.Localizable.next, for: .normal)
        }
        
        nextMonthButton.titleLabel?.textColor = .label
        
        nextMonthButton.addTarget(self, action: #selector(didTapNextMonthButton), for: .touchUpInside)
    }
    
    func setupBackButton() {
        previousMonthButton.titleLabel?.font = PartyPointResourcesFontFamily.SFProDisplay.medium.font(size: BUTTON_LABEL_FONT_SIZE)
        previousMonthButton.titleLabel?.textAlignment = .left
        previousMonthButton.titleLabel?.font = PartyPointResourcesFontFamily.SFProDisplay.medium.font(size: BUTTON_LABEL_FONT_SIZE)
        if let chevronImage = UIImage(systemName: "chevron.left.circle.fill") {
            let imageAttachment = NSTextAttachment(image: chevronImage)
            let attributedString = NSMutableAttributedString()
            
            attributedString.append(
                NSAttributedString(attachment: imageAttachment)
            )
            
            attributedString.append(
                NSAttributedString(string: " \(PartyPointResourcesStrings.Localizable.back)")
            )
            
            previousMonthButton.setAttributedTitle(attributedString, for: .normal)
        } else {
            previousMonthButton.setTitle(PartyPointResourcesStrings.Localizable.back, for: .normal)
        }
        
        previousMonthButton.titleLabel?.textColor = PartyPointResourcesAsset.miniColor.color
        
        previousMonthButton.addTarget(self, action: #selector(didTapPreviousMonthButton), for: .touchUpInside)
    }
    
    func setupSeparatedView() {
        separatorView.backgroundColor = UIColor.label.withAlphaComponent(0.2)
    }
}

//MARK: Actions
private extension CalendarPickerFooterView {
    @objc
    func didTapPreviousMonthButton() {
        didTapLastMonthCompletionHandler?()
    }
    
    @objc
    func didTapNextMonthButton() {
        didTapNextMonthCompletionHandler?()
    }
}
