import SwiftUI
import SwiftData

struct PredictionListView: View {
    let filter: FilterType
    @Query var allPredictions: [Prediction]
    
    enum FilterType { case locked, ready, opened, all }
    
    var filtered: [Prediction] {
        switch filter {
        case .locked: return allPredictions.filter { $0.openingDate > Date() }
        case .ready: return allPredictions.filter { $0.openingDate <= Date() && !$0.isOpened }
        case .opened: return allPredictions.filter { $0.isOpened }
        case .all: return allPredictions
        }
    }

    var body: some View {
        ZStack {
            Color(red: 0.75, green: 0.55, blue: 0.55).ignoresSafeArea()
            List(filtered) { pred in
                NavigationLink(destination: PredictionDetailView(prediction: pred)) {
                    HStack {
                        Text(pred.emoji)
                        Text(pred.title.isEmpty ? "Vorhersage" : pred.title)
                        Spacer()
                        Text(pred.openingDate.formatted(date: .numeric, time: .omitted)).font(.caption)
                    }
                }
                .listRowBackground(Color(red: 0.35, green: 0.25, blue: 0.45).opacity(0.8))
                .foregroundColor(.white)
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Liste")
    }
}
