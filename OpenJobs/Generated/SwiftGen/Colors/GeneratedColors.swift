// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  internal typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  internal typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
internal struct ColorName {
  internal let rgbaValue: UInt32
  internal var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f46f60"></span>
  /// Alpha: 100% <br/> (0xf46f60ff)
  internal static let coral = ColorName(rgbaValue: 0xf46f60ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#d8d8d8"></span>
  /// Alpha: 100% <br/> (0xd8d8d8ff)
  internal static let lightSilver = ColorName(rgbaValue: 0xd8d8d8ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#fd0585"></span>
  /// Alpha: 100% <br/> (0xfd0585ff)
  internal static let primary = ColorName(rgbaValue: 0xfd0585ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#000000"></span>
  /// Alpha: 100% <br/> (0x000000ff)
  internal static let shadowColor = ColorName(rgbaValue: 0x000000ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#eeeeee"></span>
  /// Alpha: 100% <br/> (0xeeeeeeff)
  internal static let tableViewBGColor = ColorName(rgbaValue: 0xeeeeeeff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#eef0f1"></span>
  /// Alpha: 100% <br/> (0xeef0f1ff)
  internal static let viewBGColor = ColorName(rgbaValue: 0xeef0f1ff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

// swiftlint:disable operator_usage_whitespace
internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

internal extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
