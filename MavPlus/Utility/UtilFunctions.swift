import Foundation

/// Conveniance function converting an ISO8601 date as a String to Date object
/// - Parameter iso: ISO8601 date information as String object
/// - Returns: The same date as a Date object, or nil if the conversion was unsuccessful
func DateFromIso(_ iso: String) -> Date? {
    return ISO8601DateFormatter().date(from: iso)
}
