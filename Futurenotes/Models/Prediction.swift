//
//  Prediction.swift
//  Futurenotes
//
//  Created by TA603 on 18.01.26.
//

import Foundation
import SwiftData // Проверь, что это тут есть

@Model // Это делает класс видимым для SwiftData
final class Prediction {
    var title: String
    var text: String
    var creationDate: Date
    var openingDate: Date
    var emoji: String
    var isOpened: Bool
    
    init(title: String = "", text: String = "", openingDate: Date = Date(), emoji: String = "😊") {
        self.title = title
        self.text = text
        self.creationDate = Date()
        self.openingDate = openingDate
        self.emoji = emoji
        self.isOpened = false
    }
}
