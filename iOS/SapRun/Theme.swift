import SwiftUI

enum Theme {
    static let background = Color(red: 0.114, green: 0.086, blue: 0.063)
    static let accent = Color(red: 0.710, green: 0.396, blue: 0.114)
    static let accent2 = Color(red: 0.910, green: 0.761, blue: 0.451)
    static let cardBackground = Color(.secondarySystemGroupedBackground)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)
}
