import SwiftUI
import SwiftData

@main
struct FuturenotesApp: App {
    @State private var language = "Deutsch"
    @State private var isDarkMode = false
    @State private var isLoggedIn = true
    
    var body: some Scene {
        WindowGroup {
            HomeView()
            NavigationStack {
                if isLoggedIn {
                    // Hier müssen die Namen (language:, isDarkMode: ...) davor stehen!
                    ConfigurationView(
                        language: $language,
                        isDarkMode: $isDarkMode,
                        isLoggedIn: $isLoggedIn
                    )
                } else {
                    VStack {
                        Text("Abgemeldet").font(.largeTitle)
                        Button("Wieder anmelden") { isLoggedIn = true }
                    }
                }
            }
            .modelContainer(for: Prediction.self) // Самая важная строка!
            .preferredColorScheme(isDarkMode ? .dark : .light)
            
        }
    }
}
