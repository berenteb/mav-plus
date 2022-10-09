import Foundation

func DateFromIso(_ iso: String) -> Date? {
    return ISO8601DateFormatter().date(from: iso)
}
