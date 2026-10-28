import SwiftUI

@main
struct IranAirApp: App {
    @StateObject private var settings = Settings()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(settings)
                .environment(\.layoutDirection, .rightToLeft)
                .environment(\.locale, Locale(identifier: "fa_IR"))
                .tint(.teal)
        }
    }
}

struct RootView: View {
    var body: some View {
        TabView {
            CitiesView()
                .tabItem { Label("شهرها", systemImage: "building.2") }
            StationsView()
                .tabItem { Label("ایستگاه‌ها", systemImage: "map") }
            SettingsView()
                .tabItem { Label("تنظیمات", systemImage: "gearshape") }
        }
    }
}
