import Foundation

struct Collection: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date = Date()
    var tapId: String
    var volume: String
    var tempF: String
}
