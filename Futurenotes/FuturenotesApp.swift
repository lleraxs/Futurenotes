import SwiftUI
import SwiftData

@main
struct FuturenotesApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: Prediction.self)
    }
}
