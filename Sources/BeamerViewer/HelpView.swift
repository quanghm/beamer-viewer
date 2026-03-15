import SwiftUI

struct HelpView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            GettingStartedTab()
                .tabItem { Label("Getting Started", systemImage: "play.circle") }
                .tag(0)

            KeyBindingsTab()
                .tabItem { Label("Key Bindings", systemImage: "keyboard") }
                .tag(1)

            BeamerSetupTab()
                .tabItem { Label("Beamer Setup", systemImage: "doc.text") }
                .tag(2)

            SupportTab()
                .tabItem { Label("Support", systemImage: "heart") }
                .tag(3)
        }
        .frame(minWidth: 500, minHeight: 450)
        .padding()
    }
}

// MARK: - Getting Started

private struct GettingStartedTab: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HelpSection(icon: "doc.badge.plus", title: "Open a PDF") {
                    Text("Click **Open PDF…** on the welcome screen, or press **⌘O**. You can also pass a file path as a command-line argument.")
                    Text("Recent files appear on the welcome screen — press **1**–**9** or **0** to open them quickly.")
                }

                HelpSection(icon: "rectangle.on.rectangle", title: "Presenter & Projector") {
                    Text("The **presenter window** shows the current slide, next slide preview, notes, and a timer.")
                    Text("The **projector window** opens automatically and shows just the current slide. Connect an external display and press **f** to go fullscreen.")
                }

                HelpSection(icon: "arrow.left.arrow.right", title: "Navigate Slides") {
                    Text("Use **arrow keys**, **Space**, **k/l**, or the **◀ ▶ buttons** to navigate.")
                    Text("Press **g** then type a slide number and **Enter** to jump directly.")
                }

                HelpSection(icon: "timer", title: "Timer") {
                    Text("The timer starts automatically when you begin presenting.")
                    Text("Press **p** to pause/resume, **r** to reset.")
                }

                HelpSection(icon: "rectangle.split.2x1", title: "Split Mode") {
                    Text("Beamer Viewer auto-detects wide PDF pages with embedded notes (from LaTeX Beamer).")
                    Text("Press **s** to cycle: **none → right → left** to manually adjust the split.")
                }

                HelpSection(icon: "display", title: "Fullscreen") {
                    Text("Press **f** or click the **fullscreen button** to toggle the projector fullscreen.")
                    Text("Press **Esc** to exit fullscreen. Press **b** to blank the projector.")
                }
            }
            .padding()
        }
    }
}

// MARK: - Key Bindings

private struct KeyBindingsTab: View {
    private let sections: [(String, [(String, String)])] = [
        ("Navigation", [
            ("→  ↓  Space  l  PgDn", "Next slide"),
            ("←  ↑  k  PgUp", "Previous slide"),
            ("Home", "First slide"),
            ("End", "Last slide"),
            ("g + number + Enter", "Go to slide"),
        ]),
        ("Presentation", [
            ("s", "Cycle split mode"),
            ("b", "Blank/unblank projector"),
            ("f", "Toggle projector fullscreen"),
        ]),
        ("Timer", [
            ("p", "Pause/resume timer"),
            ("r", "Reset timer"),
        ]),
        ("App", [
            ("h", "Toggle help"),
            ("⌘ + W", "Close presentation"),
            ("Esc", "Exit fullscreen / close help"),
            ("q", "Quit"),
        ]),
        ("Welcome Screen", [
            ("1 – 9, 0", "Open recent file"),
            ("⌘ + O", "Open file picker"),
        ]),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(sections, id: \.0) { section in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(section.0)
                            .font(.headline)
                            .padding(.bottom, 4)

                        Grid(alignment: .leading, horizontalSpacing: 24, verticalSpacing: 6) {
                            ForEach(Array(section.1.enumerated()), id: \.offset) { _, binding in
                                GridRow {
                                    Text(binding.0)
                                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                                    Text(binding.1)
                                        .font(.system(size: 14, design: .monospaced))
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Beamer Setup

private struct BeamerSetupTab: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HelpSection(icon: "doc.text", title: "What is Beamer?") {
                    Text("**Beamer** is a LaTeX document class for creating presentations. It can embed speaker notes alongside slides in the PDF.")
                }

                HelpSection(icon: "rectangle.split.2x1", title: "Enable Notes") {
                    Text("Add this to your LaTeX preamble:")
                    Text(verbatim: """
                    \\usepackage{pgfpages}
                    \\setbeameroption{show notes on second screen=right}
                    """)
                    .font(.system(size: 13, design: .monospaced))
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(RoundedRectangle(cornerRadius: 8).fill(.quaternary))

                    Text("This produces wide PDF pages with the slide on the left and notes on the right.")
                }

                HelpSection(icon: "wand.and.stars", title: "Auto-Detection") {
                    Text("Beamer Viewer automatically detects wide pages (~2:1 aspect ratio) and splits them.")
                    Text("If detection is wrong, press **s** to cycle split modes manually: **none → right → left**.")
                }

                HelpSection(icon: "note.text", title: "Adding Notes") {
                    Text("Use `\\note{}` in your Beamer source:")
                    Text(verbatim: """
                    \\begin{frame}{My Slide}
                      Content here...
                      \\note{Remember to mention the timeline.}
                    \\end{frame}
                    """)
                    .font(.system(size: 13, design: .monospaced))
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(RoundedRectangle(cornerRadius: 8).fill(.quaternary))
                }
            }
            .padding()
        }
    }
}

// MARK: - Support

private struct SupportTab: View {
    private var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "dev"
    }

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: "doc.richtext")
                .font(.system(size: 48))
                .foregroundColor(.accentColor)

            Text("Beamer Viewer")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Version \(version)")
                .foregroundStyle(.secondary)

            Text("A native PDF presenter console for Beamer slides.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            Divider().padding(.horizontal, 40)

            VStack(spacing: 12) {
                Link(destination: URL(string: "https://github.com/quanghm/beamer-viewer")!) {
                    Label("GitHub — Source Code", systemImage: "chevron.left.forwardslash.chevron.right")
                }

                Link(destination: URL(string: "https://github.com/quanghm/beamer-viewer/issues")!) {
                    Label("Report a Bug", systemImage: "ladybug")
                }
            }

            Divider().padding(.horizontal, 40)

            VStack(spacing: 4) {
                Text("Quang Hoang")
                    .fontWeight(.medium)
                Text("quanghm@gmail.com")
                    .foregroundStyle(.secondary)
                    .font(.callout)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Reusable Components

private struct HelpSection<Content: View>: View {
    let icon: String
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.accentColor)
                .frame(width: 28)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                content
                    .foregroundStyle(.secondary)
            }
        }
    }
}
