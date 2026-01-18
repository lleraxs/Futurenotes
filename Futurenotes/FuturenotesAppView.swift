
import SwiftUI

@main
struct FuturenotesApp: App {
    // Hier erstellen wir die "Quelle der Wahrheit" für deine Einstellungen.
    // Diese Variablen leben so lange, wie die App offen ist.
    @State private var language = "Deutsch"
    @State private var isDarkMode = false
    @State private var isLoggedIn = true
    
    var body: some Scene {
        WindowGroup {
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
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
