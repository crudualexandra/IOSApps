import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                BrowseView()
            }
            .tabItem {
                Label("Browse", systemImage: "film")
            }

            NavigationStack {
                MyRatingsView()
            }
            .tabItem {
                Label("Journal", systemImage: "book.pages")
            }
        }
        .tint(Color("RustAccent"))
    }
}

#Preview {
    ContentView()
        .environmentObject(RatingsViewModel())
}
