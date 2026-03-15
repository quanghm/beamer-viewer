import Foundation

@Observable
final class RecentFiles {
    static let shared = RecentFiles()
    private let key = "recentFiles"
    private let maxCount = 10

    private(set) var files: [RecentFile] = []

    struct RecentFile: Codable, Identifiable {
        let path: String
        let name: String
        let date: Date
        var id: String { path }
        var url: URL { URL(fileURLWithPath: path) }
        var exists: Bool { FileManager.default.fileExists(atPath: path) }
    }

    init() {
        load()
    }

    func add(url: URL) {
        let file = RecentFile(path: url.path, name: url.lastPathComponent, date: Date())
        files.removeAll { $0.path == file.path }
        files.insert(file, at: 0)
        if files.count > maxCount { files = Array(files.prefix(maxCount)) }
        save()
    }

    func remove(at offsets: IndexSet) {
        files.remove(atOffsets: offsets)
        save()
    }

    func clear() {
        files.removeAll()
        save()
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([RecentFile].self, from: data) else { return }
        files = decoded.filter { $0.exists }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(files) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
}
