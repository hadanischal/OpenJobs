// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  internal enum DashBoard {
    /// You have hired %d businesses
    internal static func businessCountDescription(_ p1: Int) -> String {
      return L10n.tr("DashBoard", "BUSINESS_COUNT_DESCRIPTION", p1)
    }
    /// connecting you with businesses
    internal static let businessCountNill = L10n.tr("DashBoard", "BUSINESS_COUNT_NILL")
    /// Closed
    internal static let jobTypeClosed = L10n.tr("DashBoard", "JOB_TYPE_CLOSED")
    /// In Progress
    internal static let jobTypeInProgress = L10n.tr("DashBoard", "JOB_TYPE_IN_PROGRESS")
    /// Select Job
    internal static let navigationTitle = L10n.tr("DashBoard", "NAVIGATION_TITLE")
    /// Posted: %@
    internal static func postedDate(_ p1: String) -> String {
      return L10n.tr("DashBoard", "POSTED_DATE", p1)
    }
    ///  Hired 
    internal static let statusHired = L10n.tr("DashBoard", "STATUS_HIRED")
    ///  Not Hired 
    internal static let statusNotHired = L10n.tr("DashBoard", "STATUS_NOT_HIRED")
  }
  internal enum Mock {
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
