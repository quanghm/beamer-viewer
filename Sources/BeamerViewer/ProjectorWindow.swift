import AppKit
import PDFKit

/// Fullscreen window displayed on the projector/external screen.
final class ProjectorWindowController: NSWindowController {
    private let slideManager: SlideManager
    private let slideView = SlideView()
    private var isBlank = false

    init(slideManager: SlideManager, screen: NSScreen) {
        self.slideManager = slideManager

        let window = NSWindow(
            contentRect: screen.frame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false,
            screen: screen
        )
        window.level = .screenSaver
        window.backgroundColor = .black
        window.collectionBehavior = [.fullScreenPrimary, .canJoinAllSpaces]

        super.init(window: window)

        slideView.translatesAutoresizingMaskIntoConstraints = false
        window.contentView?.addSubview(slideView)
        if let cv = window.contentView {
            NSLayoutConstraint.activate([
                slideView.topAnchor.constraint(equalTo: cv.topAnchor),
                slideView.bottomAnchor.constraint(equalTo: cv.bottomAnchor),
                slideView.leadingAnchor.constraint(equalTo: cv.leadingAnchor),
                slideView.trailingAnchor.constraint(equalTo: cv.trailingAnchor),
            ])
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    func updateSlide() {
        guard !isBlank else { return }
        let idx = slideManager.currentIndex
        slideView.pdfPage = slideManager.page(at: idx)
        slideView.cropRect = slideManager.isSplit ? slideManager.slideRect(for: idx) : nil
    }

    func toggleBlank() {
        isBlank.toggle()
        if isBlank {
            slideView.pdfPage = nil
        } else {
            updateSlide()
        }
    }

    func showOnScreen(_ screen: NSScreen) {
        window?.setFrame(screen.frame, display: true)
        window?.orderFront(nil)
    }
}
