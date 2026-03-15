import SwiftUI
import PDFKit
import Combine

/// A single persistent view that switches between welcome and presenter content.
/// Never removed from the view hierarchy, preventing window destruction issues.
struct MainView: View {
    var manager: SlideManager
    @Binding var hasDocument: Bool
    var projectorManager: ProjectorWindowManager

    var body: some View {
        Group {
            if hasDocument {
                PresenterView(manager: manager)
            } else {
                WelcomeView { url in
                    openDocument(url: url)
                }
            }
        }
        #if os(macOS)
        .onReceive(NotificationCenter.default.publisher(for: .openRecentFile)) { notification in
            if let url = notification.object as? URL {
                openDocument(url: url)
            }
        }
        #endif
        .onChange(of: hasDocument) { _, newValue in
            if newValue {
                #if os(macOS)
                projectorManager.open(manager: manager)
                #endif
            }
        }
    }

    private func openDocument(url: URL) {
        if manager.load(url: url) {
            RecentFiles.shared.add(url: url)
            hasDocument = true
        }
    }
}
