//
//  AppTextField.swift
//  PartyPoint
//
//  Created by Егор Шкарин on 12.07.2022.
//

import UIKit
import PartyPointResources

public final class PPTextField: UITextField {
    // MARK: - Enums
    
    public enum DisplayState {
        case `default`
        case error(String)
        case success
        
        func rightView() -> UIView? {
            var icon: UIImage?
            
            switch self {
            case .default:
                return nil
            case .error(_):
                icon = PartyPointResourcesAsset.icInputError.image
            case .success:
                icon = PartyPointResourcesAsset.icInputSuccess.image
            }
            
            let button = PPTextFieldRightViewButton()
            button.isUserInteractionEnabled = false
            button.setImage(icon, for: .normal)
            return button
        }
    }
    
    public enum Style {
        case dark
        case light
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let textInsetLeft: CGFloat = 12
        static let textInsetRight: CGFloat = 12
        static let borderHeight: CGFloat = 50
        
        static let titleVerticalOffset: CGFloat = 8
        static let subtitleVerticalOffset: CGFloat = 8
        
        static let borderWidth: CGFloat = 1
        static let borderCornerRadius: CGFloat = 8
    }
    
    // MARK: - Public properties
    
    /// Цветовой стиль отображения
    public var style: Style = .dark {
        didSet {
            updateStyle()
        }
    }
    
    /// Состояние отображения ошибка/успех
    public var displayState: DisplayState = .default {
        didSet {
            updateUI()
        }
    }
    
    /// Режим отображения
    public var mode: PPTextFieldMode = .none {
        didSet {
            switch mode {
            case .none:
                modePresenter = PPTextFieldMode.DefaultPresenter()
            case .secureMode:
                modePresenter = PPTextFieldMode.SecureModePresenter()
            case .clearMode:
                modePresenter = PPTextFieldMode.ClearModePresenter()
            case .disabled(infoText: let infoText):
                modePresenter = PPTextFieldMode.DisabledModePresenter(infoText: infoText)
            }
            
            updateUI()
        }
    }
    
    /// Текст над полем ввода
    public var titleText: String? {
        didSet {
            updateUI()
        }
    }
    
    /// Текст под полем ввода
    public var subtitleText: String? {
        didSet {
            updateUI()
        }
    }
    
    /// Пустое ли поле
    public var isEmpty: Bool {
        return (text ?? "").isEmpty
    }
    
    // MARK: - Internal properties
    
    /// Кастомная вью внутри поля справа
    var customRightView: UIView?
    
    // MARK: - Private properties
    
    private var borderView: UIView = {
        let borderView = UIView(frame: .zero)
        borderView.isUserInteractionEnabled = false
        borderView.layer.borderWidth = Constants.borderWidth
        borderView.layer.cornerRadius = Constants.borderCornerRadius
        return borderView
    }()
    
    private var modePresenter: PPTextFieldModePresenterProtocol = PPTextFieldMode.DefaultPresenter()
    
    /// Текст, который отобразится под текстфилдом
    private var subtitleVisibleText: String? {
        if case .error(let errorText) = displayState {
            return errorText
        }
        return subtitleText
    }
    
    private var titleLabel: UILabel?
    private var subtitleLabel: UILabel?
    
    private let colorProvider = PPTextFieldColorProvider()
    
    // MARK: - Overriden properties
    
    public override var isSecureTextEntry: Bool {
        didSet {
            updateRightView()
        }
    }
    
    public override var placeholder: String? {
        didSet {
            guard let placeholder = placeholder else { return }
            self.attributedPlaceholder =  NSAttributedString(
                string: placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: PartyPointResourcesAsset.mainColor.color.withAlphaComponent(0.5),
                             NSAttributedString.Key.font: PartyPointResourcesFontFamily.SFProDisplay.bold.font(size: 14) ]
            )
        }
    }
    
    public override var canBecomeFirstResponder: Bool {
        return modePresenter.textFieldCanBecomeFirstResponder()
    }
    
    public override func becomeFirstResponder() -> Bool {
        if super.becomeFirstResponder() {
            updateBorder()
            updateRightView()
            displayState = .default
            subtitleLabel?.isHidden = true
            return true
        }
        return false
    }
    
    public override func resignFirstResponder() -> Bool {
        if super.resignFirstResponder() {
            updateBorder()
            updateRightView()
            return true
        }
        return false
    }
    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    // MARK: - Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
        titleLabel?.frame = titleLabelRectForBounds(bounds)
        subtitleLabel?.frame = subtitleLabelRectForBounds(bounds)
        borderView.frame = textBorderRect()
    }
    
    public override var intrinsicContentSize: CGSize {
        let height = titleHeight() + textHeight() + subtitleHeight()
        return CGSize(width: bounds.width, height: height)
    }
    
    // MARK: - Drawing and positioning overrides
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        if leftView == nil {
            rect.origin.x = Constants.textInsetLeft
            rect.size.width -= Constants.textInsetLeft
        }
        if rightView == nil {
            rect.size.width -= Constants.textInsetRight
        }
        
        rect.origin.y = titleHeight()
        rect.size.height -= titleHeight()
        rect.size.height -= subtitleHeight()
        return rect
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x = Constants.textInsetLeft
        rect.origin.y = titleHeight() + textHeight() / 2 - rect.height / 2
        
        return rect
    }
    
    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.y = titleHeight() + textHeight() / 2 - rect.height / 2
        return rect
    }
    
    public override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.clearButtonRect(forBounds: bounds)
        rect.origin.x = bounds.width - rect.width - Constants.textInsetRight
        rect.origin.y = titleHeight() + textHeight() / 2 - rect.height / 2
        return rect
    }
    
    // MARK: - Public methods
    
    public func updateUI() {
        updateTitleLabel()
        updateSubtitleLabel()
        updateBorder()
        updateRightView()
        updateStyle()
        setNeedsLayout()
    }
    
    // MARK: - Private methods
    
    private func initView() {
        font = PartyPointResourcesFontFamily.SFProDisplay.bold.font(size: 16)
        
        borderStyle = .none
        addSubview(borderView)
        
        tintColor = PartyPointResourcesAsset.mainColor.color
        textColor = PartyPointResourcesAsset.mainColor.color
        
        addTarget(self, action: #selector(editingChanged),
                  for: .editingChanged)
        
        updateUI()
    }
    
    private func updateRightView() {
        rightView = nil
        
        modePresenter.setupRightView(textField: self)
    }
    
    private func updateTitleLabel() {
        createTitleIfNeeded()
        
        titleLabel?.text = titleText
        titleLabel?.textColor = colorProvider.titleColor(textField: self)
        
        if let titleLabel = titleLabel {
            modePresenter.setupTitleLabel(label: titleLabel)
        }
    }
    
    private func createTitleIfNeeded() {
        let shouldShowTitle = !(titleText ?? "").isEmpty
        guard shouldShowTitle, titleLabel == nil else {
            return
        }
        let label = UILabel(frame: .zero)
        label.font = PartyPointResourcesFontFamily.SFProDisplay.regular.font(size: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        self.titleLabel = label
        addSubview(label)
    }
    
    private func updateSubtitleLabel() {
        createSubtitleIfNeeded()
        subtitleLabel?.text = subtitleVisibleText
        subtitleLabel?.textColor = colorProvider.titleColor(textField: self)
        subtitleLabel?.isHidden = false
    }
    
    private func createSubtitleIfNeeded() {
        let shouldShowSubtitle = !(subtitleVisibleText ?? "").isEmpty
        guard shouldShowSubtitle, subtitleLabel == nil else {
            return
        }
        let label = UILabel(frame: .zero)
        label.font = PartyPointResourcesFontFamily.SFProDisplay.regular.font(size: 14)
        label.numberOfLines = 0
        self.subtitleLabel = label
        addSubview(label)
    }
    
    private func updateBorder() {
        let borderColor = colorProvider.borderColor(textField: self)
        borderView.layer.borderColor = borderColor.cgColor
    }
    
    private func updateStyle() {
        if style == .dark {
            borderView.backgroundColor = PartyPointResourcesAsset.miniColor.color
        } else {
            borderView.backgroundColor = PartyPointResourcesAsset.miniColor.color
        }
    }
    
    // MARK: - Layout rects
    
    private func titleLabelRectForBounds(_ bounds: CGRect) -> CGRect {
        guard let attrStr = titleLabel?.attributedText, !attrStr.string.isEmpty else {
            return .zero
        }
        
        let size = CGSize(width: bounds.size.width, height: 0)
        let boundingRect = attrStr.boundingRect(with: size,
                                                options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                context: nil)
        return CGRect(x: 0,
                      y: 0,
                      width: ceil(boundingRect.width),
                      height: ceil(boundingRect.height))
    }
    
    private func subtitleLabelRectForBounds(_ bounds: CGRect) -> CGRect {
        guard let subtitleText = subtitleVisibleText, !subtitleText.isEmpty else {
            return .zero
        }
        let font: UIFont = subtitleLabel?.font ?? UIFont.systemFont(ofSize: 17.0)
        
        let textAttributes = [NSAttributedString.Key.font: font]
        let size = CGSize(width: bounds.size.width, height: 0)
        let boundingRect = subtitleText.boundingRect(with: size,
                                                     options: .usesLineFragmentOrigin,
                                                     attributes: textAttributes,
                                                     context: nil)
        let rect = CGRect(x: 0,
                          y: titleHeight() + textHeight() + Constants.subtitleVerticalOffset,
                          width: ceil(boundingRect.width),
                          height: ceil(boundingRect.height))
        
        return rect
    }
    
    private func textBorderRect() -> CGRect {
        let titleHeight = self.titleHeight()
        return CGRect(x: 0, y: titleHeight, width: bounds.width, height: textHeight())
    }
    
    // MARK: - Heights
    
    private func titleHeight() -> CGFloat {
        let height = titleLabelRectForBounds(bounds).height
        return height == 0 ? 0 : height + Constants.titleVerticalOffset
    }
    
    private func textHeight() -> CGFloat {
        return Constants.borderHeight
    }
    
    private func subtitleHeight() -> CGFloat {
        let height = subtitleLabelRectForBounds(bounds).height
        return height == 0 ? 0 : height + Constants.subtitleVerticalOffset
    }
    
    // MARK: - Events actions
    @objc private func editingChanged() {
        displayState = .default
        subtitleLabel?.isHidden = true
        modePresenter.textFieldDidChange(textField: self)
    }
}
