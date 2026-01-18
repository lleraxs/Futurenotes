import Foundation
import SwiftData

@Model
final class Prediction {
    var id: UUID = UUID()
    var title: String
    var text: String
    var creationDate: Date
    var openingDate: Date
    var emoji: String
    var category: String
    var isOpened: Bool
    
    init(title: String = "", text: String = "", openingDate: Date = Date(), emoji: String = "😊", category: String = "🌱 Leben") {
        self.title = title
        self.text = text
        self.creationDate = Date()
        self.openingDate = openingDate
        self.emoji = emoji
        self.category = category
        self.isOpened = false
    }
}
