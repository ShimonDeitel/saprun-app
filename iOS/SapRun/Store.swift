import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    static let freeLimit = 10

    @Published var items: [Collection] = []
    @Published var isPro: Bool = false

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("saprun_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: Collection) {
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: Collection) {
        if let idx = items.firstIndex(where: { $0.id == item.id }) {
            items[idx] = item
            save()
        }
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Collection) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([Collection].self, from: data) else {
            items = Store.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    static func seedData() -> [Collection] {
        [
        Collection(date: Date().addingTimeInterval(-86400), tapId: "Tap 1", volume: "1.5", tempF: "38"),
        Collection(date: Date().addingTimeInterval(-172800), tapId: "Tap 2", volume: "2.0", tempF: "40"),
        Collection(date: Date().addingTimeInterval(-259200), tapId: "Tap 3", volume: "1.2", tempF: "36")
        ]
    }
}
