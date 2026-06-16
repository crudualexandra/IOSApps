import SwiftUI

@main
struct SkyPulseApp: App {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
