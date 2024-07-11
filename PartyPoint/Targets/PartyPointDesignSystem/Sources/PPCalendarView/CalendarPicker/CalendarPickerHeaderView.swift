import SnapKit
import PartyPointResources
import UIKit

private let DAY_LABEL_FONT: CGFloat = 12.scale()

class CalendarPickerHeaderView: UIView {
    lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.text = "Month"
        label.accessibilityTraits = .header
        label.isAccessibilityElement = true
        label.isUserInteractionEnabled = true
        let tapRec = UITapGestureRecognizer(target: self, action: #selector(didTapOnMonth))
        label.addGestureRecognizer(tapRec)
        return label
    }()
    
    private let arrowImageView = UIImageView(image: PartyPointResourcesAsset.calendarChevron.image)
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        
        button.tintColor = .secondaryLabel
        button.contentMode = .scaleAspectFill
        button.isUserInteractionEnabled = true
        button.isAccessibilityElement = true
        button.accessibilityLabel = "Close Picker"
        return button
    }()
    
    lazy var dayOfWeekStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.label.withAlphaComponent(0.2)
        return view
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM y")
        return dateFormatter
    }()
    
    var baseDate = Date() {
        didSet {
            monthLabel.text = dateFormatter.string(from: baseDate).capitalized
        }
    }
    
    private var isYearSelectorWillAppear: Bool = false {
        didSet (flag) {
            UIView.animate(withDuration: 0.2) {
                if flag {
                    self.arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
                } else {
                    self.arrowImageView.transform = .identity
                }
            }
        }
    }
    
    var exitButtonTappedCompletionHandler: (() -> Void)
    private var onMonthAction: ((Bool) -> Void)?
    
    init(exitButtonTappedCompletionHandler: @escaping (() -> Void)) {
        self.exitButtonTappedCompletionHandler = exitButtonTappedCompletionHandler
        
        super.init(frame: CGRect.zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = PartyPointResourcesAsset.mainColor.color
        
        layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        layer.cornerCurve = .continuous
        layer.cornerRadius = 15
        
        addSubview(monthLabel)
        addSubview(arrowImageView)
        addSubview(closeButton)
        addSubview(dayOfWeekStackView)
        addSubview(separatorView)
        
        for dayNumber in 1...7 {
            let dayLabel = UILabel()
            dayLabel.font = .systemFont(ofSize: DAY_LABEL_FONT, weight: .bold)
            dayLabel.textColor = .secondaryLabel
            dayLabel.textAlignment = .center
            dayLabel.text = dayOfWeekLetter(for: dayNumber)
            dayLabel.isAccessibilityElement = false
            dayOfWeekStackView.addArrangedSubview(dayLabel)
        }
        
        closeButton.addTarget(self, action: #selector(didTapExitButton), for: .touchUpInside)
    }
    
    @objc func didTapExitButton() {
        exitButtonTappedCompletionHandler()
    }
    
    @objc func didTapOnMonth() {
        isYearSelectorWillAppear = !isYearSelectorWillAppear
        onMonthAction?(isYearSelectorWillAppear)
    }
    
    func setOnMonthAction(_ action: @escaping (Bool) -> Void) {
        self.onMonthAction = action
    }

    required init?(coder: NSCoder) {
        return nil
    }
    
    private func dayOfWeekLetter(for dayNumber: Int) -> String {
        switch dayNumber {
        case 1:
            return PartyPointResourcesStrings.Localizable.sundayLetter
        case 2:
            return PartyPointResourcesStrings.Localizable.mondayLetter
        case 3:
            return PartyPointResourcesStrings.Localizable.tuesdayLetter
        case 4:
            return PartyPointResourcesStrings.Localizable.wednesdayLetter
        case 5:
            return PartyPointResourcesStrings.Localizable.thoursdayLetter
        case 6:
            return PartyPointResourcesStrings.Localizable.fridayLetter
        case 7:
            return PartyPointResourcesStrings.Localizable.saturdayLetter
        default:
            return ""
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            closeButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: 28),
            closeButton.widthAnchor.constraint(equalToConstant: 28),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            dayOfWeekStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dayOfWeekStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dayOfWeekStackView.bottomAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: -5),
            
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        arrowImageView.snp.makeConstraints {
            $0.left.equalTo(monthLabel.snp.right).offset(5)
            $0.size.equalTo(20)
            $0.centerY.equalTo(monthLabel.snp.centerY)
        }
    }
}
