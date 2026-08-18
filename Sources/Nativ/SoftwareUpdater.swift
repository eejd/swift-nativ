import AppKit
import Combine
import SwiftUI
#if canImport(Sparkle)
import Sparkle
#endif

@MainActor
enum NativApplicationIcon {
    static let image: NSImage = {
        guard let iconURL = Bundle.main.url(forResource: "AppIcon", withExtension: "icns"),
              let icon = NSImage(contentsOf: iconURL) else {
            return NSWorkspace.shared.icon(forFile: Bundle.main.bundlePath)
        }
        icon.isTemplate = false
        return icon
    }()

    static func registerForInAppUse() {
        let applicationIconName = NSImage.applicationIconName
        if let existingImage = NSImage(named: applicationIconName), existingImage !== image {
            existingImage.setName(nil)
        }
        image.setName(applicationIconName)
    }
}

#if canImport(Sparkle)

@MainActor
final class SoftwareUpdater {
    private let updaterController: SPUStandardUpdaterController

    var updater: SPUUpdater {
        updaterController.updater
    }

    init() {
        NativApplicationIcon.registerForInAppUse()
        updaterController = SPUStandardUpdaterController(
            startingUpdater: true,
            updaterDelegate: nil,
            userDriverDelegate: nil
        )
    }
}

@MainActor
private final class CheckForUpdatesViewModel: ObservableObject {
    @Published private(set) var canCheckForUpdates = false

    init(updater: SPUUpdater) {
        updater.publisher(for: \.canCheckForUpdates)
            .receive(on: RunLoop.main)
            .assign(to: &$canCheckForUpdates)
    }
}

struct CheckForUpdatesCommand: View {
    @ObservedObject private var viewModel: CheckForUpdatesViewModel
    private let updater: SPUUpdater

    @MainActor
    init(updater: SPUUpdater) {
        self.updater = updater
        viewModel = CheckForUpdatesViewModel(updater: updater)
    }

    var body: some View {
        Button("Check for Updates…") {
            updater.checkForUpdates()
        }
        .disabled(!viewModel.canCheckForUpdates)
    }
}

#else

// Built without the Sparkle package (e.g. a package-manager build where the
// package manager owns upgrades). Keep the same surface so call sites compile
// unchanged; the settings row explains where updates come from instead.
@MainActor
final class SoftwareUpdater {
    var updater: SoftwareUpdater { self }

    init() {
        NativApplicationIcon.registerForInAppUse()
    }
}

struct CheckForUpdatesCommand: View {
    @MainActor
    init(updater: SoftwareUpdater) {}

    var body: some View {
        Text("Updates are managed outside of Nativ.")
            .foregroundStyle(.secondary)
    }
}

#endif
