import SwiftUI

@main
struct ReelMarkApp: App {
    @StateObject private var ratingsViewModel = RatingsViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ratingsViewModel)
                .preferredColorScheme(.light)
        }
    }
}
