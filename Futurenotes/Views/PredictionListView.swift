import SwiftUI
import SwiftData

enum PredictionFilter {
    case locked, ready, opened, all
}

struct PredictionListView: View {
    let filter: PredictionFilter
    @Environment(\.dismiss) var dismiss
    @Query var allPredictions: [Prediction]
    @State private var selectedCategory: String = "Alle"
    
    let categories = ["Alle", "🌱 Leben", "📚 Schule", "💼 Arbeit", "🎯 Ziele", "✨ Sonstiges"]
    let rowPurple = Color(red: 0.35, green: 0.25, blue: 0.45)

    var filteredPredictions: [Prediction] {
        allPredictions.filter { pred in
            let matchesStatus: Bool
            switch filter {
            case .locked: matchesStatus = pred.openingDate > Date()
            case .ready: matchesStatus = pred.openingDate <= Date() && !pred.isOpened
            case .opened: matchesStatus = pred.isOpened
            case .all: matchesStatus = true
            }
            let matchesCategory = (selectedCategory == "Alle" || pred.category == selectedCategory)
            return matchesStatus && matchesCategory
        }
    }

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(categories, id: \.self) { cat in
                        Button(cat) { selectedCategory = cat }
                            .padding(.horizontal).padding(.vertical, 8)
                            .background(selectedCategory == cat ? Color.black : rowPurple.opacity(0.3))
                            .foregroundColor(.white).cornerRadius(15)
                    }
                }.padding()
            }
            
            List(filteredPredictions) { pred in
                NavigationLink(destination: PredictionDetailView(prediction: pred)) {
                    HStack {
                        Text(pred.emoji)
                        Text(pred.title.isEmpty ? "Titel..." : pred.title)
                        Spacer()
                        Text(pred.openingDate.formatted(date: .numeric, time: .omitted))
                    }
                }
            }
        }
        .navigationTitle("Nachrichten")
    }
}
