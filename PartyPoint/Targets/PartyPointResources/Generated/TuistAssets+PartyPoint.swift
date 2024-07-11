// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum PartyPointResourcesAsset {
  public static let accentColor = PartyPointColors(name: "AccentColor")
  public static let icDoneBanner = PartyPointImages(name: "icDoneBanner")
  public static let icErrorBanner = PartyPointImages(name: "icErrorBanner")
  public static let icInfoBanner = PartyPointImages(name: "icInfoBanner")
  public static let icWarningBanner = PartyPointImages(name: "icWarningBanner")
  public static let buttonColor = PartyPointColors(name: "ButtonColor")
  public static let mainColor = PartyPointColors(name: "MainColor")
  public static let miniColor = PartyPointColors(name: "MiniColor")
  public static let strokeColor = PartyPointColors(name: "stroke_color")
  public static let textFieldError = PartyPointColors(name: "text_field_error")
  public static let textFieldSelected = PartyPointColors(name: "text_field_selected")
  public static let manageLabelColor = PartyPointColors(name: "manage_label_color")
  public static let tabBarBarUnselected = PartyPointColors(name: "tabBarBarUnselected")
  public static let tabBarSelected = PartyPointColors(name: "tabBarSelected")
  public static let calendarChevron = PartyPointImages(name: "calendar_chevron")
  public static let chevronBack = PartyPointImages(name: "chevronBack")
  public static let manageChevron = PartyPointImages(name: "manage_chevron")
  public static let logo = PartyPointImages(name: "Logo")
  public static let calendar = PartyPointImages(name: "calendar")
  public static let card = PartyPointImages(name: "card")
  public static let checkbox = PartyPointImages(name: "checkbox")
  public static let closeButton = PartyPointImages(name: "close_button")
  public static let concert = PartyPointImages(name: "concert")
  public static let exit = PartyPointImages(name: "exit")
  public static let heartFill = PartyPointImages(name: "heartFill")
  public static let heartOutline = PartyPointImages(name: "heartOutline")
  public static let imagePlaceholder = PartyPointImages(name: "image_placeholder")
  public static let location = PartyPointImages(name: "location")
  public static let logoSmall = PartyPointImages(name: "logoSmall")
  public static let navigate = PartyPointImages(name: "navigate")
  public static let personPhoto = PartyPointImages(name: "personPhoto")
  public static let profileImage = PartyPointImages(name: "profile_image")
  public static let profilePerson = PartyPointImages(name: "profile_person")
  public static let search = PartyPointImages(name: "search")
  public static let searchBarIcon = PartyPointImages(name: "search_bar_icon")
  public static let shareOutline = PartyPointImages(name: "shareOutline")
  public static let time = PartyPointImages(name: "time")
  public static let unselectedHeart = PartyPointImages(name: "unselectedHeart")
  public static let unselectedWine = PartyPointImages(name: "unselectedWine")
  public static let uselectedSearch = PartyPointImages(name: "uselectedSearch")
  public static let wine = PartyPointImages(name: "wine")
  public static let icSpinnerL = PartyPointImages(name: "icSpinnerL")
  public static let icSpinnerM = PartyPointImages(name: "icSpinnerM")
  public static let icSpinnerS = PartyPointImages(name: "icSpinnerS")
  public static let icInputCalendar = PartyPointImages(name: "icInputCalendar")
  public static let icInputClear = PartyPointImages(name: "icInputClear")
  public static let icInputContacts = PartyPointImages(name: "icInputContacts")
  public static let icInputCopyText = PartyPointImages(name: "icInputCopyText")
  public static let icInputError = PartyPointImages(name: "icInputError")
  public static let icInputEye = PartyPointImages(name: "icInputEye")
  public static let icInputEyeCrossed = PartyPointImages(name: "icInputEyeCrossed")
  public static let icInputInfo = PartyPointImages(name: "icInputInfo")
  public static let icInputSuccess = PartyPointImages(name: "icInputSuccess")
  public static let icLabelLocker = PartyPointImages(name: "icLabelLocker")
  public static let connectionError = PartyPointImages(name: "connection_error")
  public static let moc = PartyPointImages(name: "moc")
  public static let noFavourties = PartyPointImages(name: "no_favourties")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class PartyPointColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension PartyPointColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  convenience init?(asset: PartyPointColors) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Color {
  init(asset: PartyPointColors) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct PartyPointImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Image {
  init(asset: PartyPointImages) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }

  init(asset: PartyPointImages, label: Text) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: PartyPointImages) {
    let bundle = Bundle.module
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
